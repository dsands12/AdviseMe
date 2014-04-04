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
		pageContext.setAttribute("course_syllabus_link", course.getSyllabusLink());
		pageContext.setAttribute("course_eval_link", course.getEvalLink());
		pageContext.setAttribute("course_num_users_rating", course.getNumRating());
		pageContext.setAttribute("course_rating", course.getAvg());
		break;
			}
		}
	%>
	<textarea rows="1" cols="1" id="fbidd" style="display:none"></textarea>
	<div class="row">
		<div class="span10">
			<div class="col-md-10">
				<h3>Title: ${fn:escapeXml(course_title)}, Abbreviation:
					${fn:escapeXml(course_abbreviation)}</h3>
			</div>
		</div>
	</div>
	
	<script>
		function GetURLParameter(sParam){
			var sPageURL = window.location.search.substring(1);
			var sURLVariables = sPageURL.split('&');
			for(var i=0;i<sURLVariables.length;i++){
				var sParameterName = sURLVariables[i].split('=');
				if(sParameterName[0]==sParam){
					return sParameterName[1];
				}
			}
		}
	
		function subscribe() {
			var email = prompt("Please enter your email","Name@Domain.com");
			var courseName = GetURLParameter('courseName');
			$.ajax({
				type : 'GET',
				url : "addcoursesubscriber?email=" + email + "&course=" + courseName,
				cache : false,
				success : function(response) {
					if(response=="true"){
					}
				}
			}); 	
		}
	</script>
	
	
	<h3>Course Difficulty: </h3><div class="rateit" id="rateit5" data-rateit-resetable="false" data-rateit-value="${fn:escapeXml(course_rating)}" data-rateit-step=".5" data-rateit-min="0" data-rateit-max="10"></div>
 <script type="text/javascript">
    $("#rateit5").bind('rated', 
    		function(event, value){
    			var courseName = GetURLParameter('courseName');
				$.ajax({
					type: 'GET',
					url: "updatecourserating?rating="+value+"&course="+courseName+"&id=${fn:escapeXml(id)}",
					cache: false,
					success: function(response){
					<!--	document.getElementById("rateit5").setAttribute("data-rateit-value",response);
					-->
					

					}
				});
			});
</script>    
<h4>Rating by: ${fn:escapeXml(course_num_users_rating)} users -  ${fn:escapeXml(course_rating)}</h4>  
	<!-- 
	2. Need to have prompt to confirm rating choice.
	3. Need to figure out possible increase in star size.
	 -->
	<br>
	<br>
	<button type="button" class="btn btn-default" onclick="subscribe()">Subscribe
		To This Course</button>
	<br>
	<br>
	<button type="button" class="btn btn-default" onclick="window.location='${fn:escapeXml(course_eval_link)}'">UT Course Evaluations</button>
	<br>
	<br>
	<button type="button" class="btn btn-default" onclick="window.location='${fn:escapeXml(course_syllabus_link)}'">UT Past Syllabi</button>
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
				<h4>Pre-Requisites:</h4>
				<br>
				<p>${fn:escapeXml(course_prereq)}</p>
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