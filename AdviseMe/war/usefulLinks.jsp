<html>

	<head>
      	<link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
        <script src="http://code.jquery.com/jquery.js"></script>
    	<script src="stylesheets/bootstrap.js"></script>
		 <title>AdviseMe-UsefulLinks</title>
	</head>
	<body>
	<img id="banner" src="Header.png" alt="Banner Image" height="84" width="263"/>
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
                    		<li><a href="courses.jsp">Courses</a></li>
                    		<li><a href="schedule.jsp">Schedule Thing</a></li> <!--  Tentative Title  -->
                    		<li class="active"><a href="usefulLinks.jsp">Useful Links</a></li>
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
		<br>
		<br>
		<div class="row-fluid">
			<div class="span1"></div>
			<div class="span4">
				<a href="http://registrar.utexas.edu/schedules">Course Schedules</a>
			</div>
			<div class="span4">
				<a href="http://www.ece.utexas.edu/undergraduate/curriculum">UT ECE Curriculum</a>
			</div>
			<div>
				<a href="https://www.myedu.com/home/">myEdu</a>
			</div>
		</div>
	</body>

</html>