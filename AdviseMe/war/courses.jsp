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
<%
	String ids = null;
	String picurl = null;
	String first = null;
	String last = null;
	String isLoggedIn = null;
	HttpSession mysession = request.getSession(false);
	if(mysession.getAttribute("id")!=null){
		ids = (String) mysession.getAttribute("userid");
		picurl = (String) mysession.getAttribute("pic");
		first = (String) mysession.getAttribute("first");
		last = (String) mysession.getAttribute("last");
		isLoggedIn = (String) mysession.getAttribute("isLoggedIn");
		pageContext.setAttribute("id", ids);
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
    		String url = "courseinfo.jsp?courseName=" + courseName;
%>

<a onclick="window.location.href='courseinfo.jsp?courseName=${fn:escapeXml(course_name)}'" class="btn custom"><b>${fn:escapeXml(course_name)}</b><br>${fn:escapeXml(course_title)}</a>
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

<a onclick="window.location.href='courseinfo.jsp?courseName=${fn:escapeXml(course_name)}'" class="btn custom"><b>${fn:escapeXml(course_name)}</b><br>${fn:escapeXml(course_title)}</a>
<%
		}
		
	
	}
      }
   %>
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