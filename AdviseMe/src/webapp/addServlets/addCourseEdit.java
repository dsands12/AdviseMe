package webapp.addServlets;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import webapp.datastoreObjects.CourseEdits;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class addCourseEdit extends HttpServlet{
	static{ObjectifyService.register(CourseEdits.class);}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String courseName = req.getParameter("coursename");
		String courseTitle = req.getParameter("coursetitle");
		String courseDescription = req.getParameter("coursedescription");
		String upperDivision = req.getParameter("division");
		String professorList = req.getParameter("professorList");
		String semesterTaught = req.getParameter("semestersTaught");
		String prereqs = req.getParameter("prereqs");
		try{
			if(courseName==null||courseName.isEmpty()){
				throw new Exception("Must provide a valid Course Name!");
			}
			if(courseTitle==null||courseTitle.isEmpty()){
				throw new Exception("Must provide a valid Course Title!");
			}
			if(courseDescription==null||courseDescription.isEmpty()){
				throw new Exception("Must provide a valid Course Description!");
			}
			if(upperDivision==null||upperDivision.isEmpty()){
				throw new Exception("Must select Upper/Lower Division!");
			}
			if(professorList==null||professorList.isEmpty()){
				throw new Exception("Must provide professors!");
			}
			if(semesterTaught==null||semesterTaught.isEmpty()){
				throw new Exception("Must provide semesters taught!");
			}
			if(prereqs==null||prereqs.isEmpty()){
				throw new Exception("Must provide textbooks!");
			}			
		boolean upper;
			if(upperDivision.equals("upper")){
				upper = true;
				
			}else{
				upper=false;
			}
			CourseEdits course = new CourseEdits(courseName,courseTitle,courseDescription,upper);
			//TODO: Need to parse the list correctly and add the professors correctly
			course.getProfessorList().add(professorList);
			course.getSemesterTaught().add(semesterTaught);
			course.getPrereq().add(prereqs);
			ObjectifyService.ofy().save().entity(course).now();
			resp.sendRedirect("thankyou.jsp");
			
			
		} catch (Exception e){
			String logMsg = "Exception in processing request: " + e.getMessage();
			throw new IOException(logMsg);
		}
	}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		doPost(req,resp);
	}
}
