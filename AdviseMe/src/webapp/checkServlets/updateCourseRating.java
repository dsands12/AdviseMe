package webapp.checkServlets;

import webapp.datastoreObjects.Course;

import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class updateCourseRating extends HttpServlet{
	static{ObjectifyService.register(Course.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String temp = req.getParameter("rating");
		String courseName = req.getParameter("course");
		String id = req.getParameter("id");
		try{
			if(temp==null||temp.isEmpty()){
				throw new Exception("Invalid rating passed to servlet.");
			}
			if(courseName==null||courseName.isEmpty()){
				throw new Exception("Invalid Course Name passed to servlet");
			}
			Double rating = Double.parseDouble(temp);
			List<Course> courses = ofy().load().type(Course.class).list();
			for(Course course: courses){
				if(course.getCourseName().equals(courseName)){
					System.out.println("Old Rating for "+courseName+"was :"+course.getAvg());
					course.processRating(rating,id); 
					System.out.println("New Rating for " + courseName+"is :"+ course.getAvg());
					ofy().save().entity(course).now();
					resp.setContentType("text/plain");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(course.getRating().toString());
					break;
				}
			}
			
		}catch(Exception e){
			String logMsg = "Exception in processing request: " + e.getMessage();
			throw new IOException(logMsg);
		}
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		doGet(req,resp);
	}
}
