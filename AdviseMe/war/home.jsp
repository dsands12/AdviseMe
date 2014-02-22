<html>
   <head> 
      <!-- > 
      old stylesheet
      <link type="text/css" rel="stylesheet" href="stylesheets/stylesheet.css"> 
      -->
      	<link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
        <script src="http://code.jquery.com/jquery.js"></script>
    	<script src="stylesheets/bootstrap.js"></script>
      <title>AdviseMe-Home</title>
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
				FB.api('/me', function(response){
					var first="Guest";
					first = response.first_name;
					var last=response.last_name;
					var id=response.id;
					if(id==null||id==""){
						first="Guest";
						last="";
					}
		    		document.getElementById("name").innerHTML="Welcome, "+first+" "+last;
		    		document.getElementById("id").innerHTML=id;
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
                    <li><a id=name></a></li>
                    <li><button type="button" class="btn btn-default" onclick="window.location.href='login.jsp'">Login</button></li>
                  </ul>
                </div>
              </div>
        	</div>
		</div>
		<div class="hero-unit">
	    	<h1>Advise Me</h1> 
	   		<p>Helping students help students in order to help students by helping!</p> 
	    	<a href="login.jsp" class="btn btn-large btn-info">Login</a>
	    	<br/><br/><br/><br/><br/>
	 		<div class="input-group">
	 			 <input type="text" class="form-control" placeholder="Search..." id="query" name="query" value="">
	 			 <button type="submit" class="btn btn-success">Submit</button>
	 		</div>
 		</div>
		<hr>
		<div class="footer">
		<p>&copy; 2013</p>
		</div>
	</body>
</html>

