<html>
<body>
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
</body>
</html>