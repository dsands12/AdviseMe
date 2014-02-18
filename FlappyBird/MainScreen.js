(function (IO) {

    "use strict";

    var MainScreen = IO.Screen.extend({

        speed: 2,
        bird: null,
        pipes: null,

        score: 0,
        state: null,

        bg: 0,
        bgOffset: 0,

        sounds: {
            "point": new IO.Sound("res/audio/sfx_point", 1)
        },

        shake: null,
        flash: null,

        init: function () {
            this.reset();
        },

        reset: function () {
            this.score = 0;
            var offset = IO.env.w * 1;
            this.state = new IO.utils.State("BORN");
            this.bird = new window.Bird(IO.env.w * 0.24, IO.env.h * 0.46, this);
            this.bg = IO.utils.rand(2);
            this.bird.setColor(IO.utils.rand(3));
            this.pipes = [
                new window.Pipe(0, "up", offset + IO.env.w, IO.env.h - 170, this.speed),
                new window.Pipe(0, "down", offset + IO.env.w, - 100, this.speed),

                new window.Pipe(1, "up", offset + (IO.env.w * 1.6), IO.env.h - 170, this.speed),
                new window.Pipe(1, "down", offset + (IO.env.w * 1.6), - 100, this.speed),

                new window.Pipe(2, "up", offset + (IO.env.w * 2.2), IO.env.h - 170, this.speed),
                new window.Pipe(2, "down", offset + (IO.env.w * 2.2), - 100, this.speed)
            ];

            this.setHeight(0);
            this.setHeight(1);
            this.setHeight(2);
        },

        tick: function () {
            this.state.tick();

            this.bird.tick();
            switch (this.state.get()) {
                case "BORN":
                    this.state.set("GETREADY");
                    this.bird.state.set("CRUSING");
                    break;
                case "GETREADY":
                    if (this.state.count > 30 && this.bird.handleKeys()) {
                        this.bird.state.set("RUNNING");
                        this.state.set("RUNNING");
                    }
                    this.moveLand();
                    break;
                case "RUNNING":
                    this.tick_RUNNING();
                    break;
                case "DYING":
                    if (this.state.first()) {
                        this.shake = new IO.Shake(30);
                        this.flash = new IO.Flash(6);
                    }
                    if (this.state.count > 20) {
                        this.state.set("GAMEOVER");
                    }
                    break;
                case "GAMEOVER":
                    if (this.state.first()) {
                        this.newBest = game.gotScore(this.score);
                    }
                    if (this.state.count > 100 && IO.input.pressed("jump")) {
                        window.game.setScreen(new MainScreen(), {type:"inout", time: 50});
                    }
                    break;
            }

            if (this.shake && !this.shake.tick()) {
                this.shake = null;
            }
            if (this.flash && !this.flash.tick()) {
                this.flash = null;
            }

        },

        tick_RUNNING: function () {

            this.moveLand();

            this.pipes = this.pipes.filter(function (p) {
                p.tick();
                if (!p.counted && p.x < this.bird.x) {
                    p.counted = true;
                    this.score += 0.5;
                    this.sounds.point.play();
                }

                if (p.reset) {
                    this.setHeight(p.group);
                }
                return true;
            }, this);

            IO.Physics.checkCollision(this.bird, this.pipes);
        },

        moveLand: function () {
            this.bgOffset -= this.speed;
            if (this.bgOffset < -IO.env.w) {
                this.bgOffset += IO.env.w;
            }
        },

        setHeight: function (group) {
            var h = (Math.random() * 160 | 0) + 130;
            this.pipes.filter(function (p) {
                return p.group === group;
            }).forEach(function (p) {
                p.y = p.dir == "up" ? h + 65 : h - p.h - 65;
            });
        },

        render: function (gfx) {
            var atlas = window.game.atlas;

            gfx.ctx.save();

            this.shake && this.shake.render(gfx);

            this.renderBG(gfx, atlas);

            this.renderGame(gfx, atlas);

            switch (this.state.get()) {
                case "GETREADY":
                    this.renderGetReady(gfx, atlas);
                    this.renderFG(gfx, atlas);
                    break;
                case "GAMEOVER":
                    this.renderFG(gfx, atlas);
                    this.renderGameOver(gfx, atlas);
                    break;
                case "RUNNING":
                    this.renderRunning(gfx, atlas);
                    this.renderFG(gfx, atlas);
                    break;
                default:
                    this.renderFG(gfx, atlas);
                    break;
            }


            gfx.ctx.restore();

            this.flash && this.flash.render(gfx);

        },

        renderBG: function (gfx, atlas) {
            atlas.render(gfx, "bg_" + (this.bg === 1 ? "night" : "day"), 0, 0);
        },

        renderGame: function (gfx) {
            this.pipes.forEach(function (p) {
                p.render(gfx);
            });
            this.bird.render(gfx);
        },

        renderFG: function (gfx, atlas) {
            atlas.render(gfx, "land", this.bgOffset, gfx.h - 112);
            atlas.render(gfx, "land", IO.env.w + this.bgOffset, gfx.h - 112);
        },

        renderRunning: function (gfx, atlas) {
            if (this.state.count < 30) {
                gfx.ctx.globalAlpha = 1 - (this.state.count / 30);
                this.renderGetReady(gfx, atlas);
                gfx.ctx.globalAlpha = 1;
            }
            this.renderScore(gfx, atlas);
        },

        renderGameOver: function (gfx, atlas) {

            var count = this.state.count,
                yOff;

            if (count > 20) {
                yOff = Math.min(5, count - 20);
                atlas.render(gfx, "text_game_over", 40, gfx.h * 0.24 + yOff);
            }

            if (count > 70) {
                yOff = Math.max(0, 330 - (count - 70) * 20);
                atlas.render(gfx, "score_panel", 24, gfx.h * 0.38 + yOff);
                var sc = this.score + "",
                    right = 218;
                for (var i = 0; i < sc.length; i++) {
                    atlas.render(gfx, "number_score_0" + sc[sc.length - i - 1], right - i * 16, 231 + yOff);
                }

                sc = window.game.best + "";
                for (i = 0; i < sc.length; i++) {
                    atlas.render(gfx, "number_score_0" + sc[sc.length - i - 1], right - i * 16, 272 + yOff);
                }

                var medal = "";
                if (this.score >= 5) medal = "3";
                if (this.score >= 10) medal = "2";
                if (this.score >= 20) medal = "1";
                if (this.score >= 30) medal = "0";
                if (medal) {
                    atlas.render(gfx, "medals_" + medal, 55, 240 + yOff);
                }

                if (this.newBest) {
                    atlas.render(gfx, "new", 165, 255 + yOff);
                }
            }

            if (count > 100) {
                atlas.render(gfx, "button_play", 20, gfx.h - 172);
                atlas.render(gfx, "button_score", 152, gfx.h - 172);
            }
        },

        renderGetReady: function (gfx, atlas) {
            atlas.render(gfx, "text_ready", 46, gfx.h * 0.285);
            atlas.render(gfx, "tutorial", 88, gfx.h * 0.425);

            this.renderScore(gfx, atlas);
        },

        renderScore: function (gfx, atlas) {
            var sc = this.score + "";
            for (var i = 0; i < sc.length; i++) {
                atlas.render(gfx, "font_0" + (48 + parseInt(sc[i], 10)), i * 18 + 130, gfx.h * 0.16);
            }
        }
    });

    window.MainScreen = MainScreen;

}(window.IO));
