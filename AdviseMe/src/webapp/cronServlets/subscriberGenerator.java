package webapp.cronServlets;

import webapp.datastoreObjects.*;

import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class subscriberGenerator extends HttpServlet{
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
		Collections.sort(courses);
		
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		doGet(req,resp);
	}

}
