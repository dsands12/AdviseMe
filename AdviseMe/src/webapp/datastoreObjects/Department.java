package webapp.datastoreObjects;

import java.util.ArrayList;

import com.googlecode.objectify.annotation.Embed;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Index
@Embed
public class Department implements Comparable<Department>{
	@Id	String name="No name entered.";
	ArrayList<Course> courseList;

	@SuppressWarnings("unused")
	private Department(){
		this.courseList = new ArrayList<Course>();
	}
	
	public Department(String name){
		this.name= name;
		this.courseList=new ArrayList<Course>();
	}
	
	public Department(ArrayList<Course> courseList){
		this.courseList=courseList;
	}

	public Department(String name, ArrayList<Course> courseList){
		this.name=name;
		this.courseList=courseList;
	}
	
	public String getName(){
		return this.name;
	}
	
	public void addCourse(Course newCourse){
		this.courseList.add(newCourse);
	}
	
	public ArrayList<Course> getCourseList() {
		return courseList;
	}

	@Override
	public int compareTo(Department o) {
		return o.getName().compareTo(this.getName());
	}
}
