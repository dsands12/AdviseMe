<html>
   <head>
      <link type="text/css" rel="stylesheet" href="stylesheets/stylesheet.css">
      <title>AdviseMe-Home</title>
      <h1>AdviseMe</h1>
   </head>
	<div class="buttonheader">
	  	<ul>
	  		<li><a href="home.jsp">Home</a></li>
	  		<li><a href="courses.jsp">Courses</a></li>
	  		<li><a href="about.jsp">About</a></li>
	  	</ul>
	</div>

	<body>		
		<h2>Test!</h2>
		<form action="/about.jsp">
			<div><input type="submit" value="Click Me!" /></div>
		</form>
		<div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
  FB.init({
    appId      : '125801300852907',
    status     : true, // check login status
    cookie     : false, // enable cookies to allow the server to access the session
    xfbml      : true  // parse XFBML
  });
  FB.Event.subscribe('auth.authResponseChange', function(response) {
    // Here we specify what we do with the response anytime this event occurs. 
    if (response.status === 'connected') {
      testAPI();
    } else if (response.status === 'not_authorized') {
      FB.login();
    } else {
      FB.login();
    }
  });
  };
  (function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   ref.parentNode.insertBefore(js, ref);
  }(document));

  // Here we run a very simple test of the Graph API after login is successful. 
  // This testAPI() function is only called in those cases. 
  function testAPI() {
	  console.log('Retrieving User ID and Name');
		FB.api('/me', {fields: 'id'},function(response){
			//need to redirect to add user servlet page to check
			var form = document.createElement("form");
		  	input = document.createElement("input");
			form.action = "/checkfacebookuser";
			form.method = "post"
			input.name = "id";
			input.value = response;
			form.appendChild(input);
			document.body.appendChild(form);
			form.submit();
		});
  }
</script>

<!--
  Below we include the Login Button social plugin. This button uses the JavaScript SDK to
  present a graphical Login button that triggers the FB.login() function when clicked. -->

<fb:login-button show-faces="true" width="200" max-rows="1"></fb:login-button>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	</body>
</html>

