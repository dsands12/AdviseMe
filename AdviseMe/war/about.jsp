<html>
	<head>
		 <link type="text/css" rel="stylesheet" href="stylesheets/bootstrap.css">
		 <title>AdviseMe-About</title>
	</head>
			<script>
			// Load FB SDK
			(function(d){
				var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
			   	if(d.getElementById(id)){
			   		return;
			   	}
			   	js = d.createElement('script'); js.id = id; js.async = true;
			   	js.src = "//connect.facebook.net/en_US/all.js";
			   	ref.parentNode.insertBefore(js, ref);
			}(document));
	  		window.fbAsyncInit = function(){
				FB.init({
					appId      : '125801300852907',
					status     : true, // check login status
					cookie     : true, // enable cookies to allow the server to access the session
					xfbml      : true  // parse XFBML
				});
	  			FB.Event.subscribe('auth.authResponseChange', function(response){
		    		if(response.status === 'connected'){
		      			checkLogin();
		    		}else if(response.status === 'not_authorized'){
		      			FB.login();
		    		}else{
		      			FB.login();
		    		}
		  		});
	  		};
	  		function checkLogin(){
				console.log('Retrieving User ID and Name');
				var picurl = "none";
				FB.api('/me', function(response){
					if(response && !response.error){
						var first="Guest";
						first = response.first_name;
						var last=response.last_name;
						var id=response.id;
						if(id==null||id==""){
							first="Guest";
							last="";
						}
			    		$.ajax({
			    			type: 'GET',
			    			url : "checkloginstatus?id="+id,
			    			cache : false,
			    			success: function(response){
			    				if(response=="true"){
						    		document.getElementById("name").innerHTML="Welcome, "+first+" "+last;
						    		document.getElementById("name").href="manageaccount.jsp";
			    					document.getElementById("pict").href="manageaccount.jsp";
						    		document.getElementById("profilepic").src=picurl;
						    		document.getElementById("loginbuttonref").setAttribute("onClick", "window.location.href='logout.jsp'");
						    		document.getElementById("loginbuttonref").innerHTML="Logout";
			    				}else{
			    					document.getElementById("name").innerHTML="Welcome, Guest";
			    					document.getElementById("name").href="home.jsp";
			    					document.getElementById("pict").href="home.jsp";
			    					document.getElementById("profilepic").src="";
						    		document.getElementById("loginbuttonref").setAttribute("onClick", "window.location.href='login.jsp'");
						    		document.getElementById("loginbuttonref").innerHTML="Login";
			    				}
			    			}
			    		});
					}
				});
				FB.api("/me/picture",{
				        "redirect": false,
				        "height": "40",
				        "type": "normal",
				        "width": "40"
				},function (response) {
					if(response && !response.error){
						picurl=response.data.url;
				    }
				});
	  		}
		</script>
		<div class="”container”"> 
			<div class="navbar">
            	<div class="navbar-inner">
                	<div class="container">
                  		<ul class="nav">
                    		<li><a href="home.jsp">Home</a></li>
                    		<li class="active"><a href="about.jsp">About</a></li>
                    		<li><a href="courses.jsp">Courses</a></li>
                    		<li><a href="usefulLinks.jsp">Useful Links</a></li>
                    		</ul>
                    		<ul class="nav pull-right">
                    		<ul class="nav">
                    		<li><a href="home.jsp" id=name></a></li>
                    			<li><a class="brand" id=pict href="home.jsp"><img id="profilepic"></a></li>
                    			<li><button type="button" class="btn btn-default" id="loginbuttonref" onclick="window.location.href='login.jsp'">Login</button></li>
                  			</ul>
                  			</ul>
                	</div>
              	</div>
        	</div>
		</div>
	
	<body>
		<div class="container">
			<div class="row-fluid">
					<div class="span4">
						<div class="col-md-4">
							<img src="http://img.photobucket.com/albums/v89/mhking/blog/cat-gun.jpg" alt="about_pic"> 
						</div>
					</div>
					<div class="span8">
						<div class="col-md-8">
							<b>AdviseMe</b> was created in the hopes of making registration for students at The University of Texas at Austin less stressful. 
							Most of the time, class descriptions are vague and students aren't aware of what they're getting into. Often times, students 
							will take multiple time-consuming classes together, buy books they never end up using, or get catch unawares on the type of 
							material being taught in a certain course. <b>AdviseMe</b> is here to resolve all those problems and make it easier to plan out 
							their schedules.
						</div>
					</div>
			</div>
			<br>
			<div class="row-fluid">
					<div class="span4">
						<div class="col-md-4">
							<h2>Meet the Team</h2>
						</div>
					</div>
					<div class="span8">
						<div class="col-md-8">
						</div>
					</div>
			</div>			
			<div class="row-fluid">
					<div class="span4">
						<div class="col-md-4">
							~name of team member here~
						</div>
					</div>
					<div class="span8">
						<div class="col-md-8">
							~some bio here~
						</div>
					</div>
			</div>
		</div>
	</body>
</html>
