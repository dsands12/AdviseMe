package webapp.cronServlets;

import webapp.datastoreObjects.*;

import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Iterator;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class userCourseGenerator extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		ObjectifyService.register(User.class);
		List<User> users = ofy().load().type(User.class).list();
		ObjectifyService.register(Course.class);
		List<Course> courses = ofy().load().type(Course.class).list();
		if(users.isEmpty()){
			System.out.println("User list was empty at Cron Time.");
			return;
		}
		if(courses.isEmpty()){
			System.out.println("Course List was empty at Cron Time");
			return;
		}
		Collections.sort(users);
		Collections.sort(courses);		Iterator<Course> temporary = courses.iterator();
		while(temporary.hasNext()){
			ArrayList<String> newlist = new ArrayList<String>();
			temporary.next().setUserTaken(newlist);
		}
		Iterator<User> userIterator = users.iterator();
		while(userIterator.hasNext()){
			User user = userIterator.next();
			System.out.println(user.getFullName());
			ArrayList<String> userCourses = user.getUserClassList();
			Iterator<String> userCourseIterator = userCourses.iterator();
			while(userCourseIterator.hasNext()){
				String userCourse = userCourseIterator.next();
				Iterator<Course> courseList = courses.iterator();
				while(courseList.hasNext()){
					Course tempCourse = courseList.next();
					if(tempCourse.getCourseName().equals(userCourse)){
						System.out.println("Adding: " + user.getfbUserId() + " to course: " + tempCourse.getCourseName());
						if(tempCourse.getUserTaken()==null){
							ArrayList<String> temp = new ArrayList<String>();
							tempCourse.setUserTaken(temp);
						}
						tempCourse.getUserTaken().add(user.getfbUserId());
					}
					ofy().save().entity(tempCourse).now();
				}
			}
		}
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		doGet(req,resp);
	}

}
