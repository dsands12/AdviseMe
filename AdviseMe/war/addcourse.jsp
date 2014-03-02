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
		<h1>Add a Course</h1>
	</head>
	<body>
		<%
		ObjectifyService.register(Course.class);
		List<Course> schools = ObjectifyService.ofy().load().type(Course.class).list();
		Collections.sort(schools);
		%>
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
		</form>
	</body>
</html>