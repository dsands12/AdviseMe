<%@ page import="java.util.*"%>
<%@ page import="webapp.datastoreObjects.Course"%>
<%@ page import="com.googlecode.objectify.Objectify"%>
<%@ page import="com.googlecode.objectify.ObjectifyService"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
	<head>
		<link type="text/css" rel="stylesheet" href="stylesheets/bootstrap.css">
		<link type="text/css" rel="stylesheet" href="rateit.css">
		<script src="http://code.jquery.com/jquery.js"></script>
		<script src="jquery.rateit.js"></script>
		<title>AdviseMe-CourseInfo</title>
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
		if(isLoggedIn.equalsIgnoreCase("true")){
			pageContext.setAttribute("readonly", "false");

		}else{
			pageContext.setAttribute("readonly", "true");
		}
		pageContext.setAttribute("guest","false");
	}else{
		pageContext.setAttribute("guest", "true");
		pageContext.setAttribute("readonly", "true");

	}
	%>
	<img id="banner" src="Header.png" alt="Banner Image" height="84" width="263"/>
	<div class="”container”">
		<div class="navbar">
			<div class="navbar-inner">
				<div class="container">
					<ul class="nav">
						<li><a href="home.jsp">Home</a></li>
						<li><a href="about.jsp">About</a></li>
						<li class="active"><a href="courses.jsp">Courses</a></li>
						<li><a href="schedule.jsp">Schedule Thing</a></li>
						<!--  Tentative Title  -->
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
		<%
		//retrieve courses
		ObjectifyService.register(Course.class);
		List<Course> courses = ObjectifyService.ofy().load().type(Course.class).list(); 
		Collections.sort(courses);
		String name = request.getParameter("courseName");
		pageContext.setAttribute("courseName",name);
		//Course current;
		//System.out.println(name);
		for(Course course : courses){
			if(course.getCourseName().equals(name)){
		//current = course;
		pageContext.setAttribute("course_title", course.getTitle());
		pageContext.setAttribute("course_abbreviation", course.getCourseName()); 
		pageContext.setAttribute("course_description", course.getDescription());
		pageContext.setAttribute("course_professorList", course.getProfessorList());
		pageContext.setAttribute("course_semestersTaught", course.getSemesterTaught());
		pageContext.setAttribute("course_prereq", course.getPrereq());
		pageContext.setAttribute("course_division", course.getUpperDivision());
		break;
			}
		}
	%>
	<form action="/changecourse" method="post">
	<div class="row">
		<div class="span10">
			<div class="col-md-10">
				<h3>Title: ${fn:escapeXml(course_title)}, Abbreviation:
					${fn:escapeXml(course_abbreviation)}</h3>
			</div>
		</div>
	</div>
	
	
	<div class="row">
		<div class="span10">
			<div class="col-md-10">
				<h4>Description:</h4>
				<br>
				<textarea name="coursedescription" rows="1" cols="30">${fn:escapeXml(course_description)}</textarea>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="span3">
			<div class="col-md-3">
				<h4>Past Professors:</h4>
				<br>
				<textarea name="professorList" rows="1" cols="30">${fn:escapeXml(course_professorList)}</textarea>
			</div>
		</div>
		<div class="span3">
			<div class="col-md-3">
				<h4>Semesters Taught:</h4>
				<br>
				<textarea name="semestersTaught" rows="1" cols="30">${fn:escapeXml(course_semestersTaught)}</textarea>
			</div>
		</div>
		<div class="span3">
			<div class="col-md-3">
				<h4>Pre-Requisites:</h4>
				<br>
				<textarea name="prereqs" rows="1" cols="30">${fn:escapeXml(course_prereq)}</textarea>
			</div>
		</div>
	</div>
	      	<input type="hidden" name="coursename" value="${fn:escapeXml(course_abbreviation)}"/>
	      	<input type="hidden" name="coursetitle" value="${fn:escapeXml(course_title)}"/>
	<input type="hidden" name="division" value="${fn:escapeXml(course_division)}"/>
	    <div><input type="submit" value="Submit Edit" /></div>
      	<input type="button" value="Cancel" onclick="window.location.href='/home.jsp'"> 
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