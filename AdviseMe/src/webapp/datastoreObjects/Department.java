package webapp.datastoreObjects;

import java.util.ArrayList;


public class Department {
	private ArrayList<Course> courseList=null;

	private Department(){
		this.courseList = new ArrayList<Course>();
	}
	
	public Department(ArrayList<Course> courseList){
		this.courseList=courseList;
	}

	public void addCourse(Course newCourse){
		this.courseList.add(newCourse);
	}
	
	public ArrayList<Course> getCourseList() {
		return courseList;
	}

}
