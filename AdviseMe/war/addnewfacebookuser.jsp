<%@ page import="webapp.addServlets.*" %>

<html>
	<head>
	  <link type="text/css" rel="stylesheet" href="stylesheets/stylesheet.css">
      <title>AdviseMe- Create User(Facebook))</title>
      <h1>Make Account (Facebook)</h1>
	</head>
	<body>
	    <form action="/addfacebookuser" method="post">
		<h3>Link Facebook Account:</h3>
      	<div><textarea name="schoolname" rows="1" cols="30"></textarea></div>
      	<div><input type="submit" value="Add School" /></div>
      	<input type="button" value="Cancel" onclick="window.location.href='/home.jsp'"> 	
	</body>


</html>