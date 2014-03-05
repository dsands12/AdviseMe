package webapp.datastoreObjects;

import java.util.ArrayList;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Index
@Entity
public class Course implements Comparable<Course> {
	@Id String courseName ="No course name entered.";
	String title = "No course title entered.";
	String description= "Default UT description";
	boolean upperDivision; 	//true if upper division; false if lower division
	ArrayList<String> professorList;
	ArrayList<String> semestersTaught;
	ArrayList<String> subscribers;
	ArrayList<String> textbooks;
	String evalLink;
	String syllabiLink;
	
	//should we make these private????
	
	@SuppressWarnings("unused")
	private Course(){}
	
	public Course(String courseName){
		this.courseName=courseName;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.subscribers = new ArrayList<String>();
		this.textbooks = new ArrayList<String>();
	}
	
	public Course(String courseName, String title){
		this.courseName=courseName;
		this.title=title;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.subscribers = new ArrayList<String>();
		this.textbooks = new ArrayList<String>();
	}
	
	public Course(String courseName, String title, String description){
		this.courseName=courseName;
		this.title=title;
		this.description=description;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.subscribers = new ArrayList<String>();
		this.textbooks = new ArrayList<String>();
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
	
	public ArrayList<String> getSubscribers(){
		return this.subscribers;
	}
	
	public ArrayList<String> getTextbooks(){
		return this.textbooks;
	}
	
	@Override
	public int compareTo(Course o) {
		return o.getCourseName().compareTo(this.getCourseName());
	}
	
}
