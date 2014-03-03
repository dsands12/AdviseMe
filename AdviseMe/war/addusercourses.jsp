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
		<script>
			// Load FB SDK
			(function(d){
				var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
			   	if(d.getElementById(id)){
			   		return;
			   	}
			   	js = d.createElement('script'); js.id = id; js.async = true;
			   	js.src = "//connect.facebook.net/en_US/all.js";
			   	ref.parentNode.insertBefore(js, ref);
			}(document));
	  		window.fbAsyncInit = function(){
				FB.init({
					appId      : '125801300852907',
					status     : true, // check login status
					cookie     : true, // enable cookies to allow the server to access the session
					xfbml      : true  // parse XFBML
				});
	  			FB.Event.subscribe('auth.authResponseChange', function(response){
		    		if(response.status === 'connected'){
		      			checkLogin();
		    		}else if(response.status === 'not_authorized'){
		      			FB.login();
		    		}else{
		      			FB.login();
		    		}
		  		});
	  		};
	  		function checkLogin(){
				console.log('Retrieving User ID and Name');
				var picurl = "none";
				FB.api('/me', function(response){
					if(response && !response.error){
						var first="Guest";
						first = response.first_name;
						var last=response.last_name;
						var id=response.id;
						document.getElementById("id").innerHTML=id;
						if(id==null||id==""){
							first="Guest";
							last="";
						}
			    		$.ajax({
			    			type: 'GET',
			    			url : "checkloginstatus?id="+id,
			    			cache : false,
			    			success: function(response){
			    				if(response=="true"){
						    		document.getElementById("name").innerHTML="Welcome, "+first+" "+last;
						    		document.getElementById("profilepic").src=picurl;
						    		document.getElementById("loginbuttonref").setAttribute("onClick", "window.location.href='logout.jsp'");
						    		document.getElementById("loginbuttonref").innerHTML="Logout";
			    				}else{
			    					document.getElementById("name").innerHTML="Welcome, Guest";
			    					document.getElementById("profilepic").src="";
						    		document.getElementById("loginbuttonref").setAttribute("onClick", "window.location.href='login.jsp'");
						    		document.getElementById("loginbuttonref").innerHTML="Login";
			    				}
			    			}
			    		});
					}
				});
				FB.api("/me/picture",{
				        "redirect": false,
				        "height": "40",
				        "type": "normal",
				        "width": "40"
				},function (response) {
					if(response && !response.error){
						picurl=response.data.url;
				    }
				});
	  		}
		</script>
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
                    		<li><a href="manageaccount.jsp" id=name></a></li>
                    			<li><a class="brand" href="manageaccount.jsp"><img id="profilepic"></a></li>
                    			<li><button type="button" class="btn btn-default" id="loginbuttonref" onclick="window.location.href='login.jsp'">Login</button></li>
                  			</ul>
                  			</ul>
                	</div>
              	</div>
        	</div>
		</div>
		<form action="/addusercourses" method="post">
			<h3>Courses:</h3>
			<h4>What courses have you taken/are taking:</h4>
			<div>
				<input type="checkbox" name="course" value="EE 302">EE 302 - Introduction to Electrical Engineering<br>
				<input type="checkbox" name="course" value="EE 302H">EE 302H - Introduction to Electrical Engineering: Honors<br>
				<input type="checkbox" name="course" value="EE 306">EE 306 - Introduction to Computing<br>
				<input type="checkbox" name="course" value="EE 312">EE 312 - Software Design and Implementation I<br>
				<input type="checkbox" name="course" value="EE 313">EE 313 - Linear System and Signals<br>
				<input type="checkbox" name="course" value="EE 316">EE 316 - Digital Logic Design<br>
				<input type="checkbox" name="course" value="EE 319K">EE 319K - Introduction to Embedded Systems<br>
				<input type="checkbox" name="course" value="EE 411">EE 411 - Circuit Theory<br>
				<input type="checkbox" name="course" value="EE 422C">EE 422C - Software Design and Implementation II<br>
				<input type="checkbox" name="course" value="EE 325">EE 325 - Electromagnetic Engineering<br>
				<input type="checkbox" name="course" value="EE 333T">EE 333T - Engineering Communication<br>
				<input type="checkbox" name="course" value="EE 125N">EE 125N - Cooperative Engineering<br>
				<input type="checkbox" name="course" value="EE 125S">EE 125S - Internship in Electrical and Computer Engineering<br>
				<input type="checkbox" name="course" value="EE 155">EE 155 - Electrical and Computer Engineering Seminar<br>
				<input type="checkbox" name="course" value="EE 155L">EE 155L - Engineering Leadership Seminar<br>
				<input type="checkbox" name="course" value="EE 160">EE 160 - Special Problems in Electrical and Computer Engineering<br>
				<input type="checkbox" name="course" value="EE 225MA">EE 225MA - Cooperative Engineering<br>
				<input type="checkbox" name="course" value="EE 225MB">EE 225MB - Cooperative Engineering<br>
				<input type="checkbox" name="course" value="EE 260">EE 260 - Special Problems in Electrical and Computer Engineering<br>
				<input type="checkbox" name="course" value="EE 460N">EE 460N - Computer Architecture<br>
				<input type="checkbox" name="course" value="EE 309S">EE 309S -Development of a Solar-Power course<br>
				<input type="checkbox" name="course" value="EE 322C">EE 322C - Data Structures <br>
				<input type="checkbox" name="course" value="EE 325K">EE 325K - Antennas and Wireless Propagation<br>
				<input type="checkbox" name="course" value="EE 325LX">EE 325LX - Cooperative Engineering<br>
				<input type="checkbox" name="course" value="EE 325LY">EE 325LY - Cooperative Engineering<br>
				<input type="checkbox" name="course" value="EE 325LZ">EE 325LZ - Cooperative Engineering<br>
				<input type="checkbox" name="course" value="EE 331">EE 331 - Electrical Circuits, Electronics, and Machinery<br>
				<input type="checkbox" name="course" value="EE 334K">EE 334K - Quantum Theory Electronic Materials<br>
				<input type="checkbox" name="course" value="EE 338K">EE 338K - Analog Electronics<br>
				<input type="checkbox" name="course" value="EE 338L">EE 338L - Analog Integrated Circuit Design<br>
				<input type="checkbox" name="course" value="EE 339">EE 339 - Solid-State Electronic Devices<br>
				<input type="checkbox" name="course" value="EE 341">EE 341 - Electric Drives and Machines<br>
				<input type="checkbox" name="course" value="EE 345M">EE 345M - Embedded and Real-Time Systems Laboratory<br>
				<input type="checkbox" name="course" value="EE 347">EE 347 - Modern Optics<br>
				<input type="checkbox" name="course" value="EE 351K">EE 351K - Probability and Random Processes<br>
				<input type="checkbox" name="course" value="EE 351M">EE 351M - Digital Signal Processing<br>
				<input type="checkbox" name="course" value="EE 360">EE 360 - Special Problems in Electrical and Computer Engineering<br>
				<input type="checkbox" name="course" value="EE 360C">EE 360C - Algorithms<br>
				<input type="checkbox" name="course" value="EE 360F">EE 360F - Introduction to Software Engineering<br>
				<input type="checkbox" name="course" value="EE 360K">EE 360K - Introduction to Digital Communications<br>
				<input type="checkbox" name="course" value="EE 360P">EE 360P - Concurrent and Distributed Systems<br>
				<input type="checkbox" name="course" value="EE 360R">EE 360R - Computer-Aided Integrated Circuit Design<br>
				<input type="checkbox" name="course" value="EE 360T">EE 360T - Software Testing<br>
				<input type="checkbox" name="course" value="EE 361Q">EE 361Q - Requirements Engineering<br>
				<input type="checkbox" name="course" value="EE 362K">EE 362K - Introduction to Automatic Control<br>
				<input type="checkbox" name="course" value="EE 362Q">EE 362Q - Power Quality and Harmonics<br>
				<input type="checkbox" name="course" value="EE 362S">EE 362S - Development of Solar-Powered Vehicle<br>
				<input type="checkbox" name="course" value="EE 363M">EE 363M - Microwave and Radio Frequency Engineering<br>
				<input type="checkbox" name="course" value="EE 363N">EE 363N - Engineering Acoustics<br>
				<input type="checkbox" name="course" value="EE 364D">EE 364D - Introduction to Engineering Design<br>
				<input type="checkbox" name="course" value="EE 366">EE 366 - Engineering Economics I<br>
				<input type="checkbox" name="course" value="EE 368L">EE 368L - Power Systems Apparatus and Laboratory<br>
				<input type="checkbox" name="course" value="EE 369">EE 369 - Power Systems Engineering<br>
				<input type="checkbox" name="course" value="EE 370N">EE 370N - Introduction to Robotics and Mechatronics<br>
				<input type="checkbox" name="course" value="EE 371R">EE 371R - Digital Image and Video Processing<br>
				<input type="checkbox" name="course" value="EE 372N">EE 372N - Telecommunication Networks<br>
				<input type="checkbox" name="course" value="EE 374K">EE 374K - Biomedical Electronics Instrument Design<br>
				<input type="checkbox" name="course" value="EE 374L">EE 374L - Applications of Biomedical Engineering<br>
				<input type="checkbox" name="course" value="EE 379K">EE 379K - Topics in ELectrical Engineering<br>
				<input type="checkbox" name="course" value="EE 438">EE 438 - Fundamentals Electronic Circuits<br>
				<input type="checkbox" name="course" value="EE 440">EE 440 - Integrated Circuit Nanomanufacturing Techniques<br>
				<input type="checkbox" name="course" value="EE 445L">EE 445L - Embedded Systems Design Laboratory<br>
				<input type="checkbox" name="course" value="EE 445S">EE 445S - Real-Time Digital Signal Processing Laboratory<br>
				<input type="checkbox" name="course" value="EE 460">EE 460 - Special Problems in Electrical and Computer Engineering<br>
				<input type="checkbox" name="course" value="EE 460M">EE 460M - Digital Systems Design Using HDL<br>
				<input type="checkbox" name="course" value="EE 460N">EE 460N - Computer Architecure<br>
				<input type="checkbox" name="course" value="EE 461L">EE 461L - Software Engineering and Design Laboratory<br>
				<input type="checkbox" name="course" value="EE 462L">EE 462L - Power Electronics Laboratory<br>
				<input type="checkbox" name="course" value="EE 464C">EE 464C - Corporate Senior Design Project<br>
				<input type="checkbox" name="course" value="EE 464G">EE 464G - Multidisciplinary Senior Design Project<br>
				<input type="checkbox" name="course" value="EE 464H">EE 464H - Honors Senior Design Project<br>
				<input type="checkbox" name="course" value="EE 464K">EE 464K - Senior Design Project<br>
				<input type="checkbox" name="course" value="EE 464R">EE 464R - Research Senior Design Project<br>
				<input type="checkbox" name="course" value="EE 471C">EE 471C - Wireless Communications Laboratory<br>
				<input type="checkbox" name="course" value="EE 679HA">EE 679HA - Undergraduate Honors Thesis<br>				
				<input type="checkbox" name="course" value="EE 679HB">EE 679HB - Undergraduate Honors Thesis<br>
			</div>
			<div>
			<div><textarea name="id" id="id" rows="1" cols="30" style="display:none;"></textarea></div>
				<input type="submit" value="Add Courses"/>
			</div>
			<input type="button" value="Cancel" onclick="window.location.href='/home.jsp'">
		</form>
	
	</body>
</html>