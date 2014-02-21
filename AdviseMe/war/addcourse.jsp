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
		ObjectifyService.register(School.class);
		List<School> schools = ObjectifyService.ofy().load()
				.type(School.class).list();
		Collections.sort(schools);
		if (schools.isEmpty()) {
	%><h1>There are no schools entered.:(</h1>
	<%
		} else if (schools.get(0).getCollegeList().isEmpty()) {
	%><h1>There are no colleges to add a department to.:(</h1>
	<%
		} else if (schools.get(0).getCollegeList().get(0)
				.getDepartmentList().isEmpty()) {//TODO: need to figure out how to first select school, then populate college list.
	%><h1>There are no departments to add course to.:(</h1>
	<%
		} else {
	%>
	<form action="/addcourse" method="post">
		<h3>School:</h3>
		<div>
			<select name="schoolname" size="1">
				<%
					for (School school : schools) {
							pageContext.setAttribute("school_name", school.getName());
				%>
				<option>${fn:escapeXml(school_name)}</option>
				<%
					}
				%>
			</select>
		</div>
		<h3>College:</h3>
		<div>
			<select name="collegename" size="1">
				<%
					for (College college : schools.get(0).getCollegeList()) {
							pageContext.setAttribute("college_name", college.getName());
				%>
				<option>${fn:escapeXml(college_name)}</option>
				<%
					}
				%>
			</select>
		</div>
		<h3>Department:</h3>
		<div>
			<select name="departmentname" size="1">
				<%
					for (Department department : schools.get(0).getCollegeList()
								.get(0).getDepartmentList()) {
							pageContext.setAttribute("department_name",
									department.getName());
				%>
				<option>${fn:escapeXml(department_name)}</option>
				<%
					}
				%>
			</select>
		</div>
		<h3>Course Name:</h3>
		<div>
			<textarea name="coursename" rows="1" cols="30"></textarea>
		</div>
		<div>
			<input type="submit" value="Add Course" />
		</div>
		<input type="button" value="Cancel"
			onclick="window.location.href='/home.jsp'">
	</form>
	<%
		}
	%>
</body>
</html>