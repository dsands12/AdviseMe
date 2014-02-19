package webapp.datastoreObjects;

import java.util.ArrayList;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class User {
	@Id String name = "No username entered.";
	ArrayList<Course> courseList;
	ArrayList<Course> currentCourses;
	
	@SuppressWarnings("unused")
	private User(){
		courseList = new ArrayList<Course>();
		currentCourses = new ArrayList<Course>();
	}
	
	public User(String name){
		this.name=name;
	}
	
	public String getUsername(){
		return this.name;
	}
}
