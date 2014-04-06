package webapp.datastoreObjects;

import java.util.ArrayList;
import java.util.HashMap;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Index
@Entity
public class CourseEdits implements Comparable<Course> {
	@Id String courseName ="No course name entered.";
	private String title = "No course title entered.";
	private String description= "Default UT description";
	private Boolean upperDivision; 	//true if upper division; false if lower division
	private ArrayList<String> professorList;
	private ArrayList<String> semestersTaught;
	private ArrayList<String> prereqs;
	
		
	@SuppressWarnings("unused")
	private CourseEdits(){}

	public CourseEdits(String courseName){
		this.courseName=courseName;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.prereqs = new ArrayList<String>();
	}
	
	public CourseEdits(String courseName, String title){
		this.courseName=courseName;
		this.title=title;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.prereqs = new ArrayList<String>();
	}
	
	public CourseEdits(String courseName, String title, String description,boolean upperDiv){
		this.courseName=courseName;
		this.title=title;
		this.description=description;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.prereqs = new ArrayList<String>();
		this.upperDivision = upperDiv;
	}
	
	public String getCourseName(){
		return this.courseName;
	}
	
	public String getTitle(){
		return this.title;
	}
	
	public String getDescription(){
		return this.description;
	}

	public boolean getUpperDivision() {
		return this.upperDivision;
	}

	public void setUpperDivision(boolean upperDivision) {
		this.upperDivision = upperDivision;
	}

	public ArrayList<String> getProfessorList(){
		return this.professorList;
	}
	
	public ArrayList<String> getSemesterTaught(){
		return this.semestersTaught;
	}
	
	public ArrayList<String> getPrereq(){
		return this.prereqs;
	}
	
	@Override
	public int compareTo(Course o) {
		return this.getCourseName().compareTo(o.getCourseName());
	}
}
