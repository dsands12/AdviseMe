package webapp.addServlets;

import webapp.datastoreObjects.*;

import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.googlecode.objectify.ObjectifyService.ofy;


@SuppressWarnings("serial")
public class addCollegeServlet extends HttpServlet{
	static{ObjectifyService.register(School.class);}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String schoolName = req.getParameter("schoolname");
		String collegeName = req.getParameter("collegename");
		if(schoolName==null){
			//Should be impossible?
		}else if(schoolName.isEmpty()){
			//Should be impossible?
		}else if(collegeName==null){
			//Should be impossible?
		}else if(collegeName.isEmpty()){
			//Should be impossible?
		}else{
			//TODO: Need to create check to make sure not adding duplicate college within school
			List<School> schoolList=ObjectifyService.ofy().load().type(School.class).list();
			Collections.sort(schoolList);
			College college = new College(collegeName);
			for(School school: schoolList){
				if(school.getName().equals(schoolName)){
					school.addCollege(college);
					ofy().save().entity(school).now();
					resp.sendRedirect("/home.jsp");
				}
			}
			resp.sendRedirect("/home.jsp"); //TODO: Really should redirect to error page showing that entity was not added.
		}
	}
}
