<%@ page import="webapp.addServlets.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<head>
	 	<link type="text/css" rel="stylesheet" href="stylesheets/stylesheet.css">
     	<title>AdviseMe- Create Account(Facebook))</title>
      	<h1>Create Account - Facebook Linked</h1>
      	<h1>${fn:escapeXml(firstname)}</h1>
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
		    		document.getElementById("first").innerHTML=first;
		    		document.getElementById("last").innerHTML=last;
		    		document.getElementById("id").innerHTML=id;
				});
			}
		</script> 
		<div class="fb-login-button" data-max-rows="1" data-size="medium" data-show-faces="false" data-auto-logout-link="false"></div>
	    <form action="/addfacebookuser" method="post">
			<h3>Create Account - Facebook Linked:</h3>
	   		<div>First Name:<textarea name="firstname" id="first" rows="1" cols="30"></textarea></div>
	   		<div>Last Name:<textarea name="lastname" id="last" rows="1" cols="30"></textarea></div>
	   		<div><textarea name="id" id="id" rows="1" cols="30" style="display:none;"></textarea></div>
	      	<div><input type="submit" value="Create Account" /></div>
	      	<input type="button" value="Cancel" onclick="window.location.href='/home.jsp'"> 	
	    </form>
	</body>
</html>