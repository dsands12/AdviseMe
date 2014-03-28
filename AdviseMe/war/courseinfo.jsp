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
<title>AdviseMe-CourseInfo</title>
</head>
<body>
	<script type="text/javascript" src="FacebookController.js">
		
	</script>
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
						<li><a href="schedule.jsp">Schedule Thing</a></li>
						<!--  Tentative Title  -->
						<li><a href="usefulLinks.jsp">Useful Links</a></li>

					</ul>
					<ul class="nav pull-right">
						<ul class="nav">
							<li><a href="home.jsp" id=name></a></li>
							<li><a class="brand" id=pict href="home.jsp"><img
									id="profilepic"></a></li>
							<li><button type="button" class="btn btn-default"
									id="loginbuttonref" onclick="window.location.href='login.jsp'">Login</button></li>
						</ul>
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
		String name = request.getParameter("name");
		//Course current;
		//System.out.println(name);
		for(Course course : courses){
			if(course.getCourseName().equals(name)){
		//current = course;
		pageContext.setAttribute("course_title", course.getTitle());
		pageContext.setAttribute("course_abbreviation", course.getCourseName()); //is this right? I'm confused as to the difference between title/name
		pageContext.setAttribute("course_description", course.getDescription());
		pageContext.setAttribute("course_professorList", course.getProfessorList());
		pageContext.setAttribute("course_semestersTaught", course.getSemesterTaught());
		pageContext.setAttribute("course_textbooks", course.getTextbooks());
		break;
			}
		}
	%>

	<div class="row">
		<div class="span10">
			<div class="col-md-10">
				<h3>Title: ${fn:escapeXml(course_title)}, Abbreviation:
					${fn:escapeXml(course_abbreviation)}</h3>
			</div>
		</div>
	</div>
	
	<script>
		function subscribe() {
			 console.log('testing'); 
		
			var email = prompt("Please enter your email","HarryPotter@verizon.net");
			
			if (email != null) {
				$.ajax({
					type : 'GET',
					url : "addcoursesubscriber?email=" + email + "&course=" + request.getParameter("name"),
					cache : false,
					success : function(response) {
						if (response == "false") {
							
						}
					}
				});  
		
			}
	
		}
		
	</script>
	
	
	
	
	<button type="button" class="btn btn-default" onclick="subscribe()">Subscribe
		To This Course</button>


	




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
		<div class="span3">
			<div class="col-md-3">
				<h4>Past Professors:</h4>
				<br>
				<p>${fn:escapeXml(course_professorList)}</p>
			</div>
		</div>
		<div class="span3">
			<div class="col-md-3">
				<h4>Semesters Taught:</h4>
				<br>
				<p>${fn:escapeXml(course_semestersTaught)}</p>
			</div>
		</div>
		<div class="span3">
			<div class="col-md-3">
				<h4>Textbooks Used:</h4>
				<br>
				<p>${fn:escapeXml(course_textbooks)}</p>
			</div>
		</div>
	</div>
	<div id="disqus_thread"></div>
	<script type="text/javascript">
		var disqus_shortname = 'adviseme'; // required: replace example with your forum shortname

		/* * * DON'T EDIT BELOW THIS LINE * * */
		(function() {
			var dsq = document.createElement('script');
			dsq.type = 'text/javascript';
			dsq.async = true;
			dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
			(document.getElementsByTagName('head')[0] || document
					.getElementsByTagName('body')[0]).appendChild(dsq);
		})();
	</script>
	<noscript>
		Please enable JavaScript to view the <a
			href="http://disqus.com/?ref_noscript">comments powered by
			Disqus.</a>
	</noscript>
	<a href="http://disqus.com" class="dsq-brlink">comments powered by
		<span class="logo-disqus">Disqus</span>
	</a>

</body>



</html>