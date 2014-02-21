package webapp.datastoreObjects;

import java.util.ArrayList;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class User implements Comparable<User>{
	@Id String fbUserId = null;
	String firstName = "No first name entered.";
	String lastName = "No last name entered.";
	ArrayList<Course> courseList;
	ArrayList<Course> currentCourses;
	
	@SuppressWarnings("unused")
	private User(){
		courseList = new ArrayList<Course>();
		currentCourses = new ArrayList<Course>();
	}
	
	public User(String fbUserId, String firstName, String lastName){
		this.fbUserId=fbUserId;
		this.firstName=firstName;
		this.lastName=lastName;
	}
	
	public String getfbUserId(){
		return this.fbUserId;
	}
	
	public String getFullName(){
		return firstName + lastName;
	}
	
	public String getLastName(){
		return this.lastName;
	}

	@Override
	public int compareTo(User o) {
		return o.getLastName().compareTo(this.getLastName());
	}
}
