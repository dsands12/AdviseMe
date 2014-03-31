package webapp.datastoreObjects;

import java.util.ArrayList;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Embed;

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
	ArrayList<String> userTaken;
	@Embed ArrayList<Comment> comments;
	String evalLink;
	String syllabiLink;
	double rating;
	
	//should we make these private????
	
	@SuppressWarnings("unused")
	private Course(){}
	
	public Course(String courseName){
		this.courseName=courseName;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.subscribers = new ArrayList<String>();
		this.textbooks = new ArrayList<String>();
		this.userTaken = new ArrayList<String>();
		this.comments = new ArrayList<Comment>();
		String[] parse = courseName.split(" ");
		if(parse.length>=2){
			if(parse[0].equalsIgnoreCase("EE")){
				this.evalLink = "https://utdirect.utexas.edu/ctl/ecis/results/"
						+ "search.WBX?s_in_search_type_sw=C&s_in_max_nbr_return"
						+ "=10&s_in_search_course_dept=E+E&s_in_search_course_num=" + parse[1];
				this.syllabiLink = "https://utdirect.utexas.edu/apps/student/"
						+ "coursedocs/nlogon/?semester=&department=E+E&course"
						+ "_number=" + parse[1]
						+ "&course_title=&unique=&instructor_first="
						+ "&instructor_last=&course_type=In+Residence&search=Search";
			}
		}
	}
	
	public Course(String courseName, String title){
		this.courseName=courseName;
		this.title=title;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.subscribers = new ArrayList<String>();
		this.textbooks = new ArrayList<String>();
		this.userTaken = new ArrayList<String>();
		this.comments = new ArrayList<Comment>();
		String[] parse = courseName.split(" ");
		if(parse.length>=2){
			if(parse[0].equalsIgnoreCase("EE")){
				this.evalLink = "https://utdirect.utexas.edu/ctl/ecis/results/"
						+ "search.WBX?s_in_search_type_sw=C&s_in_max_nbr_return"
						+ "=10&s_in_search_course_dept=E+E&s_in_search_course_num=" + parse[1];
				this.syllabiLink = "https://utdirect.utexas.edu/apps/student/"
						+ "coursedocs/nlogon/?semester=&department=E+E&course"
						+ "_number=" + parse[1]
						+ "&course_title=&unique=&instructor_first="
						+ "&instructor_last=&course_type=In+Residence&search=Search";
			}
		}
	}
	
	public Course(String courseName, String title, String description,boolean upperDiv){
		this.courseName=courseName;
		this.title=title;
		this.description=description;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.subscribers = new ArrayList<String>();
		this.textbooks = new ArrayList<String>();
		this.userTaken = new ArrayList<String>();
		this.comments = new ArrayList<Comment>();
		this.upperDivision = upperDiv;
		String[] parse = courseName.split(" ");
		if(parse.length>=2){
			if(parse[0].equalsIgnoreCase("EE")){
				this.evalLink = "https://utdirect.utexas.edu/ctl/ecis/results/"
						+ "search.WBX?s_in_search_type_sw=C&s_in_max_nbr_return"
						+ "=10&s_in_search_course_dept=E+E&s_in_search_course_num=" + parse[1];
				this.syllabiLink = "https://utdirect.utexas.edu/apps/student/"
						+ "coursedocs/nlogon/?semester=&department=E+E&course"
						+ "_number=" + parse[1]
						+ "&course_title=&unique=&instructor_first="
						+ "&instructor_last=&course_type=In+Residence&search=Search";
			}	
		}
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

	public void addSubscriber(String email){
		this.subscribers.add(email);
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
	
	public ArrayList<String> getUserTaken(){
		return this.userTaken;
	}
	
	public void setUserTaken(ArrayList<String> userTaken){
		this.userTaken=userTaken;
	}
	
	public void setSubscribers(ArrayList<String> subscribers){
		this.subscribers=subscribers;
	}
	
	public void addComment(Comment comment){
		this.comments.add(comment);
	}
	
	public ArrayList<Comment> getComments(){
		return this.comments;
	}
	@Override
	public int compareTo(Course o) {
		return this.getCourseName().compareTo(o.getCourseName());
	}
	
}
