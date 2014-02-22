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
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=125801300852907";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script> 
   <div class="”container”"> 
   <h1><a href="/home.jsp">Advise Me</a></h1>
   <div class="navbar">
              <div class="navbar-inner">
                <div class="container">
                  <ul class="nav">
                    <li class="active"><a href="home.jsp">Home</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="courses.jsp">Courses</a></li>
                    <li><a href="usefulLinks.jsp">UsefulLinks</a></li>
                  </ul>
                </div>
              </div>
            </div>
      </div>
  <h1>Courses</h1> 
  
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
   %><h1>There are no departments to add a course to.:(</h1>
   <%
      } else {
    	  
    	  for (Course course : schools.get(0).getCollegeList()
                  .get(0).getDepartmentList().get(0).getCourseList()) {
               pageContext.setAttribute("course_name",course.getCourseName());
               pageContext.setAttribute("course_title",course.getTitle());
   %>
   <h3>${fn:escapeXml(course_name)}</h3> - <h4>${fn:escapeXml(course_title)}</h4>
  
   <%
      }
      }
   %>
      
<div class="fb-comments" data-href="http://advisemeut.appspot.com/courses.jsp" data-numposts="5" data-colorscheme="light"></div>
   </body>
</html>