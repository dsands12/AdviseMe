<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
	<head> 
      	<link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
        <script src="http://code.jquery.com/jquery.js"></script>
    	<script src="stylesheets/bootstrap.js"></script>
   		<title>AdviseMe-Home</title>
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
                    		<li class="active"><a href="home.jsp">Home</a></li>
                    		<li><a href="about.jsp">About</a></li>
                    		<li><a href="courses.jsp">Courses</a></li>
                    		<li><a href="schedule.jsp">Schedule Thing</a></li> <!--  Tentative Title  -->
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
		<div class="hero-unit">
	    	<h1>Advise Me</h1> 
	   		<p>Helping students help students in order to help students by helping!</p> 
	    	<br/>
	    	<br/>
	    	<br/>
	    	<br/>
	    	<br/>
	 		  	<div class="input-group">
					<script>
					  	(function() {
					    	var cx = '001342128489850545401:ctagfguu7pg';
					   	 	var gcse = document.createElement('script');
					   	 	gcse.type = 'text/javascript';
					    	gcse.async = true;
					    	gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//www.google.com/cse/cse.js?cx=' + cx;
					    	var s = document.getElementsByTagName('script')[0];
					    	s.parentNode.insertBefore(gcse, s);
					  })();
					</script>
					<gcse:search></gcse:search>
	 		</div>
 		</div>
		<hr>
		<div class="footer">
			<p>&copy; 2014</p>
		</div>
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

