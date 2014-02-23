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

public class addDepartmentServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	static{ObjectifyService.register(School.class);}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String schoolName = req.getParameter("schoolname");
		String collegeName = req.getParameter("collegename");
		String departmentName = req.getParameter("departmentname");
		if(schoolName==null){
			//Should be impossible?
		}else if(schoolName.isEmpty()){
			//Should be impossible?
		}else if(collegeName==null){
			//Should be impossible?
		}else if(collegeName.isEmpty()){
			//Should be impossible?
		}else if(departmentName==null){
			//Should be impossible?
		}else if(departmentName.isEmpty()){
			//Should be impossible?
		}else{
			//TODO: Need to create check to make sure not adding duplicate departments within college
			List<School> schoolList=ObjectifyService.ofy().load().type(School.class).list();
			Collections.sort(schoolList);
			Department department = new Department(departmentName);
			for(School school: schoolList){
				if(school.getName().equals(schoolName)){
					for(College colleges: school.getCollegeList()){
						if(colleges.getName().equals(collegeName)){
							colleges.addDepartment(department);
							ofy().save().entity(school).now();
							resp.sendRedirect("/home.jsp");
						}
					}
				}
			}
			resp.sendRedirect("/home.jsp");
		}
	}

}
