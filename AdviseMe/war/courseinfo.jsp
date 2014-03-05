<%@ page import="java.util.*" %>
<%@ page import="webapp.datastoreObjects.Course" %>
<%@ page import="com.googlecode.objectify.Objectify" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
	<head>
		 <link type="text/css" rel="stylesheet" href="stylesheets/bootstrap.css">
		 <title>AdviseMe-CourseInfo</title>
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
                    		<li><a href="about.jsp">About</a></li>
                    		<li class="active"><a href="courses.jsp">Courses</a></li>
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
	
	<%
		//retrieve courses
		ObjectifyService.register(Course.class);
		List<Course> courses = ObjectifyService.ofy().load().type(Course.class).list(); 
		for(Course course : courses){
			pageContext.setAttribute("course_title", course.getTitle());
			pageContext.setAttribute("course_abbreviation", course.getCourseName()); //is this right? I'm confused as to the difference between title/name
			pageContext.setAttribute("course_description", course.getDescription());
		}
	%>
		<div class="row">
			<div class="span10">
				<div class="col-md-10">
					<h3>Title: ${fn:escapeXml(course_title)}, Abbreviation: ${fn:escapeXml(course_abbreviation)}</h3>
				</div>
			</div>
		</div>
		<br>
		<br>
		<div class="row">
			<div class="span10">
				<div class="col-md-10">
					<h4>Description:</h4>
					<br>
					<p>${fn:escapeXml(course_description)}</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="span4">
				<div class="col-md-4">
					<h4>Past Professors:</h4>
					<br>
					<p>${fn:escapeXml(course_professorList)}</p>
				</div>
			</div>
			<div class="span4">
				<div class="col-md-4">		
					<h4>Semesters Taught:</h4>
					<br>
					<p>${fn:escapeXml(course_semestersTaught)}</p>
				</div>
			</div>
		</div>	
	</body>



</html>