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
	<body>
	<%
	String id = null;
	String picurl = null;
	String first = null;
	String last = null;
	String isLoggedIn = null;
	HttpSession mysession = request.getSession(false);
	if(mysession.getAttribute("id")!=null){
		id = (String) mysession.getAttribute("userid");
		picurl = (String) mysession.getAttribute("pic");
		first = (String) mysession.getAttribute("first");
		last = (String) mysession.getAttribute("last");
		isLoggedIn = (String) mysession.getAttribute("isLoggedIn");
		pageContext.setAttribute("id", id);
		pageContext.setAttribute("pic",picurl);
		pageContext.setAttribute("first", first);
		pageContext.setAttribute("last", last);
		pageContext.setAttribute("isLoggedIn", isLoggedIn);
		pageContext.setAttribute("guest","false");
	}else{
		pageContext.setAttribute("guest", "true");
	}
	%>
		<img id="banner" src="Header.png" alt="Banner Image" height="84" width="263"/>
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
                    		<li><a href="home.jsp" id=name></a></li>
                    			<li><a class="brand" id=pict href="home.jsp"><img id="profilepic"></a></li>
                    			<li><button type="button" class="btn btn-default" id="loginbuttonref" onclick="window.location.href='login.jsp'">Login</button></li>
                  			</ul>
                	</div>
              	</div>
        	</div>
		</div>
	<form class="well" action="/addcourse" method="post">  
	  <label>Course Abbreviation</label>  
	  	<textarea name="coursename" rows="1" cols="30" placeholder="Enter Abbrev..."></textarea>
	  	<span class="help-inline">Ex. EE 360C</span>   
	  <br/> 
	  
	  <label>Course Title</label>  
	  	<textarea name="coursetitle" rows="1" cols="30" placeholder="Enter Title..."></textarea>  
	  	<span class="help-inline">Ex. Algorithms</span>   
	  <br>
	  
	  <label>Course Description</label>  
	  	<textarea name="coursedescription" rows="3" cols="30" placeholder="Enter Description..."></textarea>  
	  	<span class="help-inline">Ex. This course involves...</span>   
	  <br>
	  
	  <label>Upper/Lower Division</label> 
	  	<input type="radio" name="division" value="upper">Upper
	  	<input type="radio" name="division" value="lower">Lower
	  <br><br>
	  
	  <label>Professors</label>  
	  	<textarea name="professorList" rows="3" cols="30" placeholder="Enter Professors..."></textarea>  
	  	<span class="help-inline">Comma separated list (Ex. Julien,Ghosh,etc...)</span>   
	  <br>
	  
	  <label>Semesters Taught</label>  
	  	<textarea name="semestersTaught" rows="3" cols="30" placeholder="Enter Semesters..."></textarea>  
	  	<span class="help-inline">Comma separated list (Ex. Fall 2012,Spring 2013,Summer 2013,etc...)</span>   
	  <br>
	  
	  <label>Textbooks</label>  
	  	<textarea name="textbooks" rows="3" cols="30" placeholder="Enter Textbooks..."></textarea>  
	  	<span class="help-inline">Comma separated list (Ex. Title Author ISBN,etc...)</span>   
	  <br>
	  
	  <button type="submit" class="btn" >Add Course</button>  
	</form>
	<script>
	if ("${fn:escapeXml(guest)}" == "false") {
		console.log('1');
		if("${fn:escapeXml(isLoggedIn)}" == "true"){
			console.log('2');
			document.getElementById("name").innerHTML = "Welcome, ${fn:escapeXml(first)} ${fn:escapeXml(last)}";
			document.getElementById("name").href = "manageaccount.jsp";
			document.getElementById("pict").href = "manageaccount.jsp";
			document.getElementById("profilepic").src = "${fn:escapeXml(pic)}";
			document.getElementById("loginbuttonref").setAttribute("onClick","window.location.href='logout.jsp'");
			document.getElementById("loginbuttonref").innerHTML = "Logout";
		}else{
			console.log('3');
			document.getElementById("name").innerHTML = "Welcome, Guest";
			document.getElementById("name").href = "home.jsp";
			document.getElementById("pict").href = "home.jsp";
			document.getElementById("profilepic").src = "";
			document.getElementById("loginbuttonref").setAttribute("onClick","window.location.href='login.jsp'");
			document.getElementById("loginbuttonref").innerHTML = "Login";
		}
	} else {
		console.log('4');
		document.getElementById("name").innerHTML = "Welcome, Guest";
		document.getElementById("name").href = "home.jsp";
		document.getElementById("pict").href = "home.jsp";
		document.getElementById("profilepic").src = "";
		document.getElementById("loginbuttonref").setAttribute("onClick","window.location.href='login.jsp'");
		document.getElementById("loginbuttonref").innerHTML = "Login";
	}
	</script>
	</body>
</html>