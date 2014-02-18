package webapp.datastoreObjects;

public class Course {
	private String title = "No title entered.";
	private String description= "No description available.";
	
	private Course(){}
	
	public Course(String title){
		this.title=title;
	}
	
	public Course(String title, String description){
		this.title=title;
		this.description=description;
	}
	
	public String getTitle(){
		return title;
	}
	
	public String getDescription(){
		return description;
	}
	
}
