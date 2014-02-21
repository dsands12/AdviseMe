package webapp.datastoreObjects;

import java.util.ArrayList;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Index
@Entity
public class User implements Comparable<User>{
	@Id String fbUserId = null;
	String firstName = "No first name entered.";
	String lastName = "No last name entered.";
	ArrayList<Course> courseList;
	ArrayList<Course> currentCourses;
	
	@SuppressWarnings("unused")
	/**Empty Constructor for User Object
	 * 
	 */
	private User(){
		courseList = new ArrayList<Course>();
		currentCourses = new ArrayList<Course>();
	}
	
	/**Constructor for User Object
	 * 
	 * @param firstName - First Name of User
	 * @param lastName - Last Name of User
	 */
	public User(String firstName, String lastName){
		this.fbUserId=null;
		this.firstName=firstName;
		this.lastName=lastName;
		courseList = new ArrayList<Course>();
		currentCourses = new ArrayList<Course>();
	}
	
	/**Constructor for User Object
	 * 
	 * @param fbUserId - FaceBook User Id
	 * @param firstName - First Name of User
	 * @param lastName - Last Name of User
	 */
	public User(String fbUserId, String firstName, String lastName){
		this.fbUserId=fbUserId;
		this.firstName=firstName;
		this.lastName=lastName;
		courseList = new ArrayList<Course>();
		currentCourses = new ArrayList<Course>();
	}
	
	public String getfbUserId(){
		return this.fbUserId;
	}
	
	public void addfbUserId(String fbID){
		this.fbUserId=fbID;
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
