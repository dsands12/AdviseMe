<%@ page import="webapp.addServlets.*" %>
<%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
	<head>
	    <link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
        <script src="http://code.jquery.com/jquery.js"></script>
    	<script src="stylesheets/bootstrap.js"></script>
     	<title>AdviseMe- Create Account</title>
      	<h1>Create Account</h1>
	</head>
	<body>
	<img id="banner" src="Header.png" alt="Banner Image" height="84" width="263"/>
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
                	</div>
              	</div>
        	</div>
		</div>
		<div class="fb-login-button" data-scope="email" data-max-rows="1" data-size="medium" data-show-faces="false" data-auto-logout-link="false"></div>
	    <form action="/addfacebookuser" method="post">
	   		<div>First Name:<textarea name="firstname" id="first" rows="1" cols="30"></textarea></div>
	   		<div>Last Name:<textarea name="lastname" id="last" rows="1" cols="30"></textarea></div>
	   		<div>Email:<textarea name="email" id="email" rows="1" cols="30"></textarea></div>
	   		<div><textarea name="id" id="id" rows="1" cols="30" style="display:none;"></textarea></div>
	   		<%
         	ReCaptcha c = ReCaptchaFactory.newReCaptcha("6LfFIe8SAAAAAFvovPN2pD-lUKHixmEufNFITZ91", "6LfFIe8SAAAAADGueFM28Toq3H3OJWqB2xTpoj-A", false);
         	out.print(c.createRecaptchaHtml(null, null));
      		%>
	      	<div><input type="submit" value="Create Account" /></div>
	      	<input type="button" value="Cancel" onclick="window.location.href='/home.jsp'"> 	
	    </form>
	</body>
</html>