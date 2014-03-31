<html>
	<head> 
		<link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
		<script src="http://code.jquery.com/jquery.js"></script>
		<script src="stylesheets/bootstrap.js"></script>
		<title>AdviseMe - Manage Account</title>
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
		<div class="hero-unit">
				<form action="/removefacebookuser" method="get" onSubmit="return confirm('Are you sure you want to delete your account')">
	   		<div><textarea name="id" id="id" rows="1" cols="30" style="display:none;" ></textarea></div>
	      	<div><input type="submit" value="Delete Account" /></div>
	    </form>
	    	    	<a onclick="window.location.href='addusercourses.jsp'" id="usercoursesbuttonref" class="btn btn-large btn-info">Manage Courses</a>
	    
 		</div>
		
	</body>
</html>