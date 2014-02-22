package webapp.datastoreObjects;

import java.util.ArrayList;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Index
@Entity
public class School implements Comparable<School>{
	@Id String name="No school name entered.";
	ArrayList<College> collegeList;
	
	@SuppressWarnings("unused")
	private School(){
		collegeList = new ArrayList<College>();
	}
	
	public School(String name){
		this.name=name;
		this.collegeList=new ArrayList<College>();
	}
	
	public School(ArrayList<College> collegeList){
		this.collegeList = collegeList;
	}
	
	public School(String name, ArrayList<College> collegeList){
		this.name=name;
		this.collegeList=collegeList;
	}
	
	public String getName(){
		return this.name;
	}
	
	public void addCollege(College newCollege){
		this.collegeList.add(newCollege);
	}
	
	public ArrayList<College> getCollegeList(){
		return collegeList;
	}

	@Override
	public int compareTo(School o) {
		return o.getName().compareTo(this.getName());
	}
}
