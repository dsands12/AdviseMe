package webapp.datastoreObjects;

import com.googlecode.objectify.annotation.Embed;
import com.googlecode.objectify.annotation.Index;

@Index
@Embed
public class Course implements Comparable<Course> {
	String courseName ="No course name entered.";
	String title = "No course title entered.";
	String description= "No course description available.";
	
	@SuppressWarnings("unused")
	private Course(){}
	
	public Course(String courseName){
		this.courseName=courseName;
	}
	
	public Course(String courseName, String title, String description){
		this.courseName=courseName;
		this.title=title;
		this.description=description;
	}
	
	public String getCourseName(){
		return this.courseName;
	}
	
	public String getTitle(){
		return title;
	}
	
	public String getDescription(){
		return description;
	}

	@Override
	public int compareTo(Course o) {
		return o.getCourseName().compareTo(this.getCourseName());
	}
	
}
