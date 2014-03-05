<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="webapp.addServlets.*"%>
<%@ page import="webapp.datastoreObjects.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>
<%@ page import="com.googlecode.objectify.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<meta charset=”utf-8”>
<head>
   <link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
   <script src="http://code.jquery.com/jquery.js"></script>
   <script src="stylesheets/bootstrap.js"></script>

   <title>AdviseMe-Courses</title>
</head>

<body>  
<div id="fb-root"></div>
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
                    		<li><a href="schedule.jsp">Schedule Thing</a></li> <!--  Tentative Title  -->
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
  <h1>Courses</h1> 
  <%
      ObjectifyService.register(Course.class);
      List<Course> schools = ObjectifyService.ofy().load().type(Course.class).list();
      Collections.sort(schools);
      if (schools.isEmpty()) {
   %><h1>There are no courses entered.:(</h1>
   <%
      } else {
    	%>
    		<h3>Upper Division</h3>
    	<%
    		for(Course course : schools){
    			Boolean upperDiv=course.getUpperDivision();
    			if( upperDiv == true){
               pageContext.setAttribute("course_name",course.getCourseName());
               pageContext.setAttribute("course_title",course.getTitle());
               String courseName=course.getCourseName();
               %><script>
	    		document.getElementById("<%=courseName%>");
	    		</script><%
	    		String url = "courseinfo.jsp?name=" + courseName;
   %>

  <a onclick="window.location.href='courseinfo.jsp?name=${fn:escapeXml(course_name)}'" id="usercoursesbuttonref" class="btn custom"><b>${fn:escapeXml(course_name)}</b><br>${fn:escapeXml(course_title)}</a>
   <%
    			}
    			
    			
      }
    	%>
		<h3>Lower Division</h3>
	<%
		for(Course course : schools){
			Boolean upperDiv=course.getUpperDivision();
			if( upperDiv == false){
           pageContext.setAttribute("course_name",course.getCourseName());
           pageContext.setAttribute("course_title",course.getTitle());
           String courseName=course.getCourseName();
           %><script>
    		document.getElementById("<%=courseName%>");
    		</script><%
    		String url = "courseinfo.jsp?name=" + courseName;
%>

<a onclick="window.location.href='courseinfo.jsp?name=${fn:escapeXml(course_name)}'" id="usercoursesbuttonref" class="btn custom"><b>${fn:escapeXml(course_name)}</b><br>${fn:escapeXml(course_title)}</a>
<%
			}
      }
      }
   %>
   </body>
</html>