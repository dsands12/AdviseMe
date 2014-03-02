<html>
	<head> 
		<link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
		<script src="http://code.jquery.com/jquery.js"></script>
		<script src="stylesheets/bootstrap.js"></script>
		<title>AdviseMe - Manage Account</title>
	</head>
	<body>
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
				FB.api('/me', function(response){
					var first=response.first_name;
					var last=response.last_name;
					var id=response.id;
					var email=response.email;
		    		document.getElementById("first").innerHTML=first;
		    		document.getElementById("last").innerHTML=last;
		    		document.getElementById("id").innerHTML=id;
		    		document.getElementById("email").innerHTML=email;
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
                    		<li><a href="manageaccount.jsp" id=name></a></li>
                    		<li><a class="brand" href="manageaccount.jsp"><img id=profilepic></a></li>
                    		<li><button type="button" class="btn btn-default" onclick="window.location.href='login.jsp'">Login</button></li>
                  		</ul>
                	</div>
              	</div>
        	</div>
		</div>
		<form action="/removefacebookuser" method="get">
	   		<div><textarea name="id" id="id" rows="1" cols="30" style="display:none;" onSubmit="return confirm('Are you sure you want to delete your account')"></textarea></div>
	      	<div><input type="submit" value="Delete Account" /></div>	
	    </form>
	</body>
</html>