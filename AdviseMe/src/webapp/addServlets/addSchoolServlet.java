package webapp.addServlets;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class addSchoolServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	//static{ObjectifyService.register(School.class);}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
	/*	String schoolName = req.getParameter("schoolname");
		if(schoolName==null){
			//do nothing. submitted form with no school name.
		}else if(schoolName.isEmpty()){
			//do nothing. submitted form with no school name.
		}else{
			// TODO: Need to create check to make sure not adding duplicate school.
			School school = new School(schoolName);
			ofy().save().entities(school).now();
			resp.sendRedirect("/home.jsp");
		}*/
	}
}
