package webapp.datastoreObjects;

import java.util.ArrayList;
import java.util.HashMap;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Index
@Entity
public class Course implements Comparable<Course> {
	@Id String courseName ="No course name entered.";
	private String title = "No course title entered.";
	private String description= "Default UT description";
	private Boolean upperDivision; 	//true if upper division; false if lower division
	private ArrayList<String> professorList;
	private ArrayList<String> semestersTaught;
	private ArrayList<String> subscribers;
	private ArrayList<String> textbooks;
	private ArrayList<String> userTaken;
	private String evalLink;
	private String syllabiLink;
	private Integer numRating; 
	private HashMap<String,Double> ratings;
	private Double avg=0.0;
	
		
	@SuppressWarnings("unused")
	private Course(){}

	public Course(String courseName){
		this.ratings = new HashMap<String,Double>();
		this.ratings.put("default", 0.0);
		this.courseName=courseName;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.subscribers = new ArrayList<String>();
		this.textbooks = new ArrayList<String>();
		this.userTaken = new ArrayList<String>();
		this.numRating=0;
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
		this.ratings = new HashMap<String,Double>();
		this.ratings.put("default", 0.0);
		this.courseName=courseName;
		this.title=title;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.subscribers = new ArrayList<String>();
		this.textbooks = new ArrayList<String>();
		this.userTaken = new ArrayList<String>();
		this.numRating=0;
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
		this.ratings = new HashMap<String,Double>();
		this.ratings.put("default", 0.0);
		this.courseName=courseName;
		this.title=title;
		this.description=description;
		this.professorList = new ArrayList<String>();
		this.semestersTaught = new ArrayList<String>();
		this.subscribers = new ArrayList<String>();
		this.textbooks = new ArrayList<String>();
		this.userTaken = new ArrayList<String>();
		this.upperDivision = upperDiv;
		this.numRating=0;
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
	
	public String getSyllabusLink(){
		return this.syllabiLink;
	}
	
	public String getEvalLink(){
		return this.evalLink;
	}
	
	public void setUserTaken(ArrayList<String> userTaken){
		this.userTaken=userTaken;
	}
	
	public void setSubscribers(ArrayList<String> subscribers){
		this.subscribers=subscribers;
	}
	
	@Override
	public int compareTo(Course o) {
		return this.getCourseName().compareTo(o.getCourseName());
	}
		
	public Integer getNumRating(){
		return this.numRating;
	}
	
	public void processRating(Double rating, String fbID){
		if(this.ratings.containsKey(fbID)&&(this.ratings.get(fbID)!=rating)){
			int userCount = this.numRating;
			Double temp = userCount*this.avg;
			this.avg=(temp-this.ratings.get(fbID)+rating)/(userCount);
			this.ratings.put(fbID, rating);
			return;
		}else if(this.ratings.containsKey(fbID)&&(this.ratings.get(fbID)==rating)){
			return;
		}else{
			this.ratings.put(fbID, rating);
		}
		if(avg==0.0){
			this.avg=rating;
			this.numRating=1;
		}else{
			int userCount = this.numRating;
			Double temp = userCount*this.avg;
			temp+=rating;
			this.numRating+=1;
			this.avg=temp/this.numRating;	
		}
	}
	
	public Double getAvg() {
		return this.avg;
	}
	
	public void resetRating(){
		if(this.ratings!=null){
			this.ratings.clear();
			this.avg = 0.0;
			this.numRating=0;
			System.out.println(ratings.size());
			this.ratings.put("default", 0.0);
		}
	}
}
