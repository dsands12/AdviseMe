function login() {

	// Load FB SDK
	(function(d) {
		var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
		if (d.getElementById(id)) {
			return;
		}
		js = d.createElement('script');
		js.id = id;
		js.async = true;
		js.src = "//connect.facebook.net/en_US/all.js";
		ref.parentNode.insertBefore(js, ref);
	}(document));
	window.fbAsyncInit = function() {
		FB.init({
			appId : '125801300852907',
			status : true, // check login status
			cookie : true, // enable cookies to allow the server to access the
			// session
			xfbml : true
		// parse XFBML
		});
		FB.Event.subscribe('auth.authResponseChange', function(response) {
			if (response.status === 'connected') {
				checkLogin();
			} else if (response.status === 'not_authorized') {
				FB.login();
			} else {
				FB.login();
			}
		});
	};
	function checkLogin() {
		console.log('Retrieving User ID and Name');
		var picurl = "none";
		FB.api(
						'/me',
						function(response) {
							if (response && !response.error) {
								var first = "Guest";
								first = response.first_name;
								var last = response.last_name;
								var id = response.id;
								if (id == null || id == "") {
									first = "Guest";
									last = "";
								}
								$.ajax({
											type : 'GET',
											url : "checkloginstatus?id=" + id,
											cache : false,
											success : function(response) {
												if (response == "true") {
													document.getElementById("name").innerHTML = "Welcome, " + first + " " + last;
													document.getElementById("name").href = "manageaccount.jsp";
													document.getElementById("pict").href = "manageaccount.jsp";
													document.getElementById("profilepic").src = picurl;
													document.getElementById("loginbuttonref").setAttribute("onClick","window.location.href='logout.jsp'");
													document.getElementById("loginbuttonref").innerHTML = "Logout";
													document.getElementById("usercoursesbuttonref").setAttribute("onClick","window.location.href='addusercourses.jsp?id="+id+"'");
													document.getElementById("fbidd").innerHTML = id;
												} else {
													document.getElementById("name").innerHTML = "Welcome, Guest";
													document.getElementById("name").href = "home.jsp";
													document.getElementById("pict").href = "home.jsp";
													document.getElementById("profilepic").src = "";
													document.getElementById("loginbuttonref").setAttribute("onClick","window.location.href='login.jsp'");
													document.getElementById("loginbuttonref").innerHTML = "Login";
												}
											}
										});
							}
						});
		FB.api("/me/picture", {
			"redirect" : false,
			"height" : "40",
			"type" : "normal",
			"width" : "40"
		}, function(response) {
			if (response && !response.error) {
				picurl = response.data.url;
			}
		});
	}

}
