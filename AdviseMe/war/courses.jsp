<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="webapp.addServlets.*"%>
<%@ page import="webapp.datastoreObjects.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.util.*"%>
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
	<script type="text/javascript" src="FacebookController.js"> </script>
		<script type="text/javascript">
				login();
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
    	Iterator<Course> upperIterator = schools.iterator();
    	while (upperIterator.hasNext()){
    		Course currentCourse = upperIterator.next(); 
			Boolean upperDiv=currentCourse.getUpperDivision();
			if( upperDiv == true){
           pageContext.setAttribute("course_name",currentCourse.getCourseName());
           pageContext.setAttribute("course_title",currentCourse.getTitle());
           String courseName=currentCourse.getCourseName();
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
	Iterator<Course> lowerIterator = schools.iterator();
	while (lowerIterator.hasNext()){
		Course currentCourse = lowerIterator.next(); 
		Boolean upperDiv=currentCourse.getUpperDivision();
		if( upperDiv == false){
       pageContext.setAttribute("course_name",currentCourse.getCourseName());
       pageContext.setAttribute("course_title",currentCourse.getTitle());
       String courseName=currentCourse.getCourseName();
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