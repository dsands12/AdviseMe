<html>
	<head>
	    <link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
        <script src="http://code.jquery.com/jquery.js"></script>
    	<script src="stylesheets/bootstrap.js"></script>
	</head>
	<body>
		<div id="fb-root"></div>
		<script>
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
		(function(d){
			var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
			if(d.getElementById(id)){
				return;
			}
			js = d.createElement('script'); js.id = id; js.async = true;
			js.src = "//connect.facebook.net/en_US/all.js";
			ref.parentNode.insertBefore(js, ref);
		}(document));
		function checkLogin(){
			console.log('Retrieving User ID and Name');
			FB.api('/me', function(response){
				var id=response.id;
				var form = document.createElement("form");
				input = document.createElement("input");
				form.action = "/checkfacebookuser";
				form.method = "post"
				input.name = "id";
				input.value = response.id;
				form.appendChild(input);
				document.body.appendChild(form);
				form.submit();
			});
		}
		</script>
		<h1>Login</h1>
		<div class="hero-unit">
    		<div class="fb-login-button" data-max-rows="1" data-size="large" data-show-faces="true" data-auto-logout-link="false"></div>
 		</div>		
	</body>
</html>