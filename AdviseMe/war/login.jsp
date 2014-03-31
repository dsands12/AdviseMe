<html>
	<head>
	    <link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
        <script src="http://code.jquery.com/jquery.js"></script>
    	<script src="stylesheets/bootstrap.js"></script>
	</head>
	<body>
	<img id="banner" src="Header.png" alt="Banner Image" height="84" width="263"/>
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
			    	FB.login({
			    		scope: 'basic_info'
			    	});
			    }else{
			    	FB.login({
			    		scope: 'basic_info'
			    	});
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
			document.getElementById("test").innerHTML="Logging In....Redirecting";
			FB.api('/me', function(response){
				var id=response.id;
				console.log(id);
				$.ajax({
					type:'GET',
					url : "checkfacebookuser?id="+id,
					cache : false,
					success: function(response){
						console.log(response);
						if(response=="true"){
							console.log("user is registered");
						}else if(response=="false"){
							window.location.replace('createaccount.jsp');
						}
					}
				});
				$.ajax({
					type:'GET',
					url : "changeloginstatus?id="+id,
					cache : false,
					success: function(response){
						window.location.replace('home.jsp');
					}
				});
			});
		}
		</script>
		<div class="”container”"> 
			<div class="navbar">
            	<div class="navbar-inner">
                	<div class="container">
                  		<ul class="nav">
                    		<li class="active"><a href="home.jsp">Home</a></li>
                    		<li><a href="about.jsp">About</a></li>
                    		<li><a href="courses.jsp">Courses</a></li>
                    		<li><a href="usefulLinks.jsp">Useful Links</a></li>
                	</div>
              	</div>
        	</div>
		</div>
		<div class="hero-unit">
			<h2 id="test"></h2>
    		<div class="fb-login-button" data-scope="email" data-max-rows="1" data-size="large" data-show-faces="true" data-auto-logout-link="false"></div>
 		</div>		
	</body>
</html>