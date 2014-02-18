package webapp.datastoreObjects;

import java.util.ArrayList;

public class School {
	private ArrayList<College> collegeList;
	
	private School(){
		collegeList = new ArrayList<College>();
	}
	
	public School(ArrayList<College> collegeList){
		this.collegeList = collegeList;
	}
	
	public void addCollege(College newCollege){
		this.collegeList.add(newCollege);
	}
	
	public ArrayList<College> getCollegeList(){
		return collegeList;
	}
}
