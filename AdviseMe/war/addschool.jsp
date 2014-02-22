<%@ page import="webapp.addServlets.*" %>

<html>
   <head>
      	<link href="stylesheets/bootstrap.css" rel="stylesheet" media="screen">
        <script src="http://code.jquery.com/jquery.js"></script>
    	<script src="stylesheets/bootstrap.js"></script>
      <title>AdviseMe- Add Schools</title>
      <h1>Add a School</h1>
   </head>
   <body>      
    	<form action="/addschool" method="post">
		<h3>School Name:</h3>
      	<div><textarea name="schoolname" rows="1" cols="30"></textarea></div>
      	<div><input type="submit" value="Add School" /></div>
      	<input type="button" value="Cancel" onclick="window.location.href='/home.jsp'"> 
    </form> 
   </body>
</html>