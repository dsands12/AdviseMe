<html>
	<head> 
		<link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
		<script src="http://code.jquery.com/jquery.js"></script>
		<script src="stylesheets/bootstrap.js"></script>
		<title>AdviseMe - Manage Account</title>
	</head>
	<body>	
		<div class="”container”"> 
			<div class="navbar">
            	<div class="navbar-inner">
                	<div class="container">
                  		<ul class="nav">
                    		<li class="active"><a href="home.jsp">Home</a></li>
                    		<li><a href="about.jsp">About</a></li>
                    		<li><a href="courses.jsp">Courses</a></li>
                    		<li><a href="usefulLinks.jsp">Useful Links</a></li>
                    		<li><a href="manageaccount.jsp" id=name></a></li>
                    		<li><a class="brand" href="manageaccount.jsp"><img id=profilepic></a></li>
                    		<li><button type="button" class="btn btn-default" onclick="window.location.href='login.jsp'">Login</button></li>
                  		</ul>
                	</div>
              	</div>
        	</div>
		</div>
		<div class="hero-unit">
	    	<h3>Manage Account</h3>  
	    	<a href="home.jsp" class="btn btn-large btn-info">Delete Account</a>
	    	<br/><br/><br/><br/><br/>
	 		<div class="input-group">
	 			 <input type="text" class="form-control" placeholder="Search..." id="query" name="query" value="">
	 			 <button type="submit" class="btn btn-success">Submit</button>
	 		</div>
 		</div>
	</body>
</html>