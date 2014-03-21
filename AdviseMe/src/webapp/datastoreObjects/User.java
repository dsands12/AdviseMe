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
	String userEmail = null;
	Boolean loginStatus = false;
	ArrayList<String> courseList;
	ArrayList<String> fbFriends;
	
	@SuppressWarnings("unused")
	private User(){
		courseList = new ArrayList<String>();
	}
	
	public User(String firstName, String lastName){
		this.fbUserId=null;
		this.firstName=firstName;
		this.lastName=lastName;
		this.userEmail=null;
		this.loginStatus = false;
		courseList = new ArrayList<String>();
	}
	
	public User(String fbUserId, String firstName, String lastName){
		this.fbUserId=fbUserId;
		this.firstName=firstName;
		this.lastName=lastName;
		this.userEmail=null;
		this.loginStatus=false;
		courseList = new ArrayList<String>();
	}
	
	public User(String fbUserId, String firstName, String lastName, String userEmail){
		this.fbUserId=fbUserId;
		this.firstName=firstName;
		this.lastName=lastName;
		this.userEmail=userEmail;
		this.loginStatus=false;
		courseList = new ArrayList<String>();
	}
	
	public ArrayList<String> getUserClassList(){
		return courseList;
	}
	
	public void addUserClass(String course){
		courseList.add(course);
	}
	
	public String getfbUserId(){
		return this.fbUserId;
	}
	
	public void addfbUserId(String fbID){
		this.fbUserId=fbID;
	}
	
	public String getFullName(){
		return firstName + " " + lastName;
	}
	
	public String getLastName(){
		return this.lastName;
	}

	public String getUserEmail(){
		return this.userEmail;
	}
	
	public Boolean getLoginStatus(){
		return loginStatus;
	}
	
	public void setLoginStatus(boolean status){
		this.loginStatus=status;
	}
	
	@Override
	public int compareTo(User o) {
		return o.getLastName().compareTo(this.getLastName());
	}
}
