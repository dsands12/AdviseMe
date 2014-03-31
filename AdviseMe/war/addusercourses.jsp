<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="webapp.addServlets.*"%>
<%@ page import="webapp.datastoreObjects.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>
<%@ page import="com.googlecode.objectify.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
	<head>
    	<link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
        <script src="http://code.jquery.com/jquery.js"></script>
    	<script src="stylesheets/bootstrap.js"></script>
		<title>AdviseMe- Add Courses</title>
	</head>
	<body>
		<script type="text/javascript" src="FacebookController.js"> </script>
		<script type="text/javascript">
				login();
		</script>
		<img id="banner" src="Header.png" alt="Banner Image" height="84" width="263"/>
		<div class="”container”"> 
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
		<%
		String fbID = request.getParameter("id");
		%>
		<form action="/addusercourses?id=<%=fbID%>" method="post">
			<h3>Courses:</h3>
			<h4>What courses have you taken/are taking:</h4>
			<div>
				<input type="checkbox" name="course" id="EE 125N" value="EE 125N">EE 125N - Cooperative Engineering<br>
				<input type="checkbox" name="course" id="EE 125S" value="EE 125S">EE 125S - Internship in Electrical and Computer Engineering<br>
				<input type="checkbox" name="course" id="EE 155" value="EE 155">EE 155 - Electrical and Computer Engineering Seminar<br>
				<input type="checkbox" name="course" id="EE 155L" value="EE 155L">EE 155L - Engineering Leadership Seminar<br>
				<input type="checkbox" name="course" id="EE 160" value="EE 160">EE 160 - Special Problems in Electrical and Computer Engineering<br>
				<input type="checkbox" name="course" id="EE 225MA" value="EE 225MA">EE 225MA - Cooperative Engineering<br>
				<input type="checkbox" name="course" id="EE 225MB" value="EE 225MB">EE 225MB - Cooperative Engineering<br>
				<input type="checkbox" name="course" id="EE 260" value="EE 260">EE 260 - Special Problems in Electrical and Computer Engineering<br>
				<input type="checkbox" name="course" id="EE 302" value="EE 302">EE 302 - Introduction to Electrical Engineering<br>
				<input type="checkbox" name="course" id="EE 302H" value="EE 302H">EE 302H - Introduction to Electrical and Computer Engineering: Honors<br>
				<input type="checkbox" name="course" id="EE 306" value="EE 306">EE 306 - Introduction to Computing<br>
				<input type="checkbox" name="course" id="EE 309S" value="EE 309S">EE 309S - Development of a Solar-Powered Vehicle<br>
				<input type="checkbox" name="course" id="EE 312" value="EE 312">EE 312 - Software Design and Implementation I<br>
				<input type="checkbox" name="course" id="EE 313" value="EE 313">EE 313 - Linear Systems and Signals<br>
				<input type="checkbox" name="course" id="EE 316" value="EE 316">EE 316 - Digital Logic Design<br>
				<input type="checkbox" name="course" id="EE 319K" value="EE 319K">EE 319K - Introduction to Embedded Systems<br>
				<input type="checkbox" name="course" id="EE 322C" value="EE 322C">EE 322C - Data Structures<br>
				<input type="checkbox" name="course" id="EE 325" value="EE 325">EE 325 - Electromagnetic Engineering<br>
				<input type="checkbox" name="course" id="EE 325K" value="EE 325K">EE 325K - Antennas and Wireless Propagation<br>
				<input type="checkbox" name="course" id="EE 325LX" value="EE 325LX">EE 325LX - Cooperative Engineering<br>
				<input type="checkbox" name="course" id="EE 325LY" value="EE 325LY">EE 325LY - Cooperative Engineering<br>
				<input type="checkbox" name="course" id="EE 325LZ" value="EE 325LZ">EE 325LZ - Cooperative Engineering<br>
				<input type="checkbox" name="course" id="EE 331" value="EE 331">EE 331 - Electrical Circuits, Electronics, and Machinery<br>
				<input type="checkbox" name="course" id="EE 333T" value="EE 333T">EE 333T - Engineering Communication<br>
				<input type="checkbox" name="course" id="EE 334K" value="EE 334K">EE 334K - Quantum Theory Electronic Materials<br>
				<input type="checkbox" name="course" id="EE 338K" value="EE 338K">EE 338K - Analog Electronics<br>
				<input type="checkbox" name="course" id="EE 338L" value="EE 338L">EE 338L - Analog Integrated Circuit Design<br>
				<input type="checkbox" name="course" id="EE 339" value="EE 339">EE 339 - Solid-State Electronic Devices<br>
				<input type="checkbox" name="course" id="EE 341" value="EE 341">EE 341 - Electric Drives and Machines<br>
				<input type="checkbox" name="course" id="EE 347" value="EE 347">EE 347 - Modern Optics<br>
				<input type="checkbox" name="course" id="EE 351K" value="EE 351K">EE 351K - Probability and Random Processes<br>
				<input type="checkbox" name="course" id="EE 351M" value="EE 351M">EE 351M - Digital Signal Processing<br>
				<input type="checkbox" name="course" id="EE 360" value="EE 360">EE 360 - Special Problems in Electrical and Computer Engineering<br>
				<input type="checkbox" name="course" id="EE 360C" value="EE 360C">EE 360C - Algorithms<br>
				<input type="checkbox" name="course" id="EE 360F" value="EE 360F">EE 360F - Intro to Software Engineering<br>
				<input type="checkbox" name="course" id="EE 360K" value="EE 360K">EE 360K - Introduction to Digital Communications<br>
				<input type="checkbox" name="course" id="EE 360P" value="EE 360P">EE 360P - Concurrent and Distributed Systems<br>
				<input type="checkbox" name="course" id="EE 360R" value="EE 360R">EE 360R - Computer-Aided Integrated Circuit Design<br>
				<input type="checkbox" name="course" id="EE 360T" value="EE 360T">EE 360T - Software Testing<br>
				<input type="checkbox" name="course" id="EE 361Q" value="EE 361Q">EE 361Q - Requirements Engineering<br>
				<input type="checkbox" name="course" id="EE 362K" value="EE 362K">EE 362K - Introduction to Automatic Control<br>
				<input type="checkbox" name="course" id="EE 362Q" value="EE 362Q">EE 362Q - Power Quality and Harmonics<br>
				<input type="checkbox" name="course" id="EE 362S" value="EE 362S">EE 362S - Development of Solar-Powered Vehicle<br>
				<input type="checkbox" name="course" id="EE 363M" value="EE 363M">EE 363M - Microwave and Radio Frequency Engineering<br>
				<input type="checkbox" name="course" id="EE 363N" value="EE 363N">EE 363N - Engineering Acoustics<br>
				<input type="checkbox" name="course" id="EE 364D" value="EE 364D">EE 364D - Introduction to Engineering Design<br>
				<input type="checkbox" name="course" id="EE 364E" value="EE 364E">EE 364E - Interdiscip Entrepreneurship<br>
				<input type="checkbox" name="course" id="EE 366" value="EE 366">EE 366 - Engineering Economics I<br>
				<input type="checkbox" name="course" id="EE 368L" value="EE 368L">EE 368L - Power Systems Apparatus and Laboratory<br>
				<input type="checkbox" name="course" id="EE 369" value="EE 369">EE 369 - Power Systems Engineering<br>
				<input type="checkbox" name="course" id="EE 370K" value="EE 370K">EE 370K - Computer Control Systems<br>
				<input type="checkbox" name="course" id="EE 370N" value="EE 370N">EE 370N - Introduction to Robotics and Mechatronics<br>
				<input type="checkbox" name="course" id="EE 371R" value="EE 371R">EE 371R - Digital Image and Video Processing<br>
				<input type="checkbox" name="course" id="EE 372N" value="EE 372N">EE 372N - Telecommunication Networks<br>
				<input type="checkbox" name="course" id="EE 374K" value="EE 374K">EE 374K - Biomedical Electronics Instrument Design<br>
				<input type="checkbox" name="course" id="EE 374L" value="EE 374L">EE 374L - Applications of Biomedical Engineering - EE MAJ<br>
				<input type="checkbox" name="course" id="EE 377E" value="EE 377E">EE 377E - Interdiscip Entrepreneurship: Electv<br>
				<input type="checkbox" name="course" id="EE 379K" value="EE 379K">EE 379K - Topics in Electrical Engineering<br>
				<input type="checkbox" name="course" id="EE 411" value="EE 411">EE 411 - Circuit Theory<br>
				<input type="checkbox" name="course" id="EE 422C" value="EE 422C">EE 422C - Software Design and Implementation II<br>
				<input type="checkbox" name="course" id="EE 438" value="EE 438">EE 438 - Fundamentals Electronic Circuits<br>
				<input type="checkbox" name="course" id="EE 440" value="EE 440">EE 440 - Integrated Circuit Nanomanufacturing Techniques<br>
				<input type="checkbox" name="course" id="EE 445L" value="EE 445L">EE 445L - Embedded Systems Design Lab<br>
				<input type="checkbox" name="course" id="EE 445M" value="EE 445M">EE 445M - Embedded and Real-Time Systems Laboratory<br>
				<input type="checkbox" name="course" id="EE 445S" value="EE 445S">EE 445S - Real-Time Digital Sig Proc Lab<br>
				<input type="checkbox" name="course" id="EE 460" value="EE 460">EE 460 - Special Problems in Electrical and Computer Engineering<br>
				<input type="checkbox" name="course" id="EE 460M" value="EE 460M">EE 460M - Digital Systems Design Using HDL<br>
				<input type="checkbox" name="course" id="EE 460N" value="EE 460N">EE 460N - Computer Architecture<br>
				<input type="checkbox" name="course" id="EE 460R" value="EE 460R">EE 460R - Introduction to VLSI Design<br>
				<input type="checkbox" name="course" id="EE 461L" value="EE 461L">EE 461L - Software Engineering and Design Laboratory<br>
				<input type="checkbox" name="course" id="EE 462L" value="EE 462L">EE 462L - Power Electronics Laboratory<br>
				<input type="checkbox" name="course" id="EE 464C" value="EE 464C">EE 464C - Corporate Senior Design Project<br>
				<input type="checkbox" name="course" id="EE 464G" value="EE 464G">EE 464G - Multidisciplinary Senior Design Project<br>
				<input type="checkbox" name="course" id="EE 464H" value="EE 464H">EE 464H - Honors Senior Design Project<br>
				<input type="checkbox" name="course" id="EE 464K" value="EE 464K">EE 464K - Senior Design Project<br>
				<input type="checkbox" name="course" id="EE 464R" value="EE 464R">EE 464R - Research Senior Design Project<br>
				<input type="checkbox" name="course" id="EE 464S" value="EE 464S">EE 464S - Start-Up Senior Design Project<br>
				<input type="checkbox" name="course" id="EE 471C" value="EE 471C">EE 471C - Wireless Communications Laboratory<br>
				<input type="checkbox" name="course" id="EE 679HA" value="EE 679HA">EE 679HA - Undergraduate Honors Thesis<br>
				<input type="checkbox" name="course" id="EE 679HB" value="EE 679HB">EE 679HB - Undergraduate Honors Thesis<br>
			</div>
			<div>
			<div><textarea name="id" id="id" rows="1" cols="30" style="display:none;"></textarea></div>
				<input type="submit" value="Add Courses"/>
			</div>
			<input type="button" value="Cancel" onclick="window.location.href='/home.jsp'">
		</form>
		<%
			ObjectifyService.register(User.class);
			List<User> users = ObjectifyService.ofy().load().type(User.class).list();
			Collections.sort(users);
			String id = request.getParameter("id");
			for(User user: users){
				if(user.getfbUserId().equals(id)){
					ArrayList<String> courseList = user.getUserClassList();
					Iterator<String> iterator = courseList.iterator();
					while(iterator.hasNext()){
						String identifier = (String)iterator.next();
						%><script>
			    		document.getElementById("<%=identifier%>").checked=true;
			    		</script>
			    		<%
					}
					break;
				}
			}
		%>
	</body>
</html>