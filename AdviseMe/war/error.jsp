<%@ page isErrorPage="true"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>An Error has Occurred:'(</title>
	</head>
	<body>
	<img id="banner" src="Header.png" alt="Banner Image" height="84" width="263"/>
		<h1>Oh No!</h1>
		<hr/>
		<h3>An error has occurred, and you have been redirected here to prevent any possible damage!</h3>
		<h3><b>Reason: </b><%=exception.getMessage() %></h3>
		<hr/>
		<a href="home.jsp">Back to Home Page</a>
	</body>
</html>