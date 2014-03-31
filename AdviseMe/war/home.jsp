<%@ page import="webapp.datastoreObjects.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.googlecode.objectify.*" %>
<html>
	<head> 
      	<link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
        <script src="http://code.jquery.com/jquery.js"></script>
    	<script src="stylesheets/bootstrap.js"></script>
   		<title>AdviseMe-Home</title>
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
		<div class="hero-unit">
	    	<h1>Advise Me</h1> 
	   		<p>Helping students help students in order to help students by helping!</p> 
	    	<!--<a onclick="window.location.href='login.jsp'" id="loginbuttonref" class="btn btn-large btn-info">Login</a> -->
	    	<br/><br/><br/><br/><br/>
	 		<!--  <div class="input-group">
	 			 <input type="text" class="form-control" placeholder="Search..." id="query" name="query" value="">
	 			 <button type="submit" class="btn btn-success">Submit</button>
	 			 
	 		</div>
	 		-->
 		</div>
		<hr>
		<div class="footer">
		<p>&copy; 2014</p>
		</div>
		
	</body>
</html>

