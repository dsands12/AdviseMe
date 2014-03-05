<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="webapp.addServlets.*"%>
<%@ page import="webapp.datastoreObjects.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>
<%@ page import="com.googlecode.objectify.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
	<head>
    	<link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
        <script src="http://code.jquery.com/jquery.js"></script>
    	<script src="stylesheets/bootstrap.js"></script>
		<title>AdviseMe- Add Courses</title>
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
			<div class="â€�containerâ€�"> 
			<div class="navbar">
            	<div class="navbar-inner">
                	<div class="container">
                  		<ul class="nav">
                    		<li class="active"><a href="home.jsp">Home</a></li>
                    		<li><a href="about.jsp">About</a></li>
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
	<form class="well" action="/addcourse" method="post">  
	  <label>Course Abbreviation</label>  
	  	<textarea name="coursename" rows="1" cols="30" placeholder="Enter Abbrev..."></textarea>
	  	<span class="help-inline">Ex. EE 360C</span>   
	  </label> 
	  <br/> 
	  
	  <label>Course Title</label>  
	  	<textarea name="coursetitle" rows="1" cols="30" placeholder="Enter Title..."></textarea>  
	  	<span class="help-inline">Ex. Algorithms</span>   
	  </label> 
	  <br>
	  
	  <label>Course Description</label>  
	  	<textarea name="coursedescription" rows="3" cols="30" placeholder="Enter Description..."></textarea>  
	  	<span class="help-inline">Ex. This course involves...</span>   
	  </label> 
	  <br>
	  
	  <label>Upper/Lower Division</label> 
	  	<td><input type="radio" name="division" value="upper">Upper&nbsp&nbsp
	  	<td><input type="radio" name="division" value="lower">Lower
	  </label> 
	  <br><br>
	  
	  <label>Professors</label>  
	  	<textarea name="professorList" rows="3" cols="30" placeholder="Enter Professors..."></textarea>  
	  	<span class="help-inline">Comma separated list (Ex. Julien,Ghosh,etc...)</span>   
	  </label> 
	  <br>
	  
	  <label>Semesters Taught</label>  
	  	<textarea name="semestersTaught" rows="3" cols="30" placeholder="Enter Semesters..."></textarea>  
	  	<span class="help-inline">Comma separated list (Ex. Fall 2012,Spring 2013,Summer 2013,etc...)</span>   
	  </label> 
	  <br>
	  
	  <label>Textbooks</label>  
	  	<textarea name="textbooks" rows="3" cols="30" placeholder="Enter Textbooks..."></textarea>  
	  	<span class="help-inline">Comma separated list (Ex. Title Author ISBN,etc...)</span>   
	  </label> 
	  <br>
	  
	  <button type="submit" class="btn" >Add Course</button>  
	  <button type="Cancel" class="btn" onclick="window.location.href='/home.jsp'">Cancel</button>
	</form>
	
<%--	
		<form action="/addcourse" method="post">
			<h3>Course Name:</h3>
			<div>
				<textarea name="coursename" rows="1" cols="30">Course Abbrev.</textarea>
				<textarea name="coursetitle" rows="1" cols="30">Course Title</textarea>
			</div>
			<div>
				<input type="submit" value="Add Course" />
			</div>
			<input type="button" value="Cancel" onclick="window.location.href='/home.jsp'">
		</form> --%>
	</body>
</html>