package webapp.datastoreObjects;

import java.util.ArrayList;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class College implements Comparable<College> {
	@Id String name="No college name entered.";
	ArrayList<Department> departmentList;
	
	@SuppressWarnings("unused")
	private College(){
		departmentList = new ArrayList<Department>();
	}
	
	public College(String name){
		this.name=name;
		this.departmentList= new ArrayList<Department>();
	}
	
	public College(ArrayList<Department> departmentList){
		this.departmentList = departmentList;
	}
	
	public College(String name, ArrayList<Department> departmentList){
		this.name=name;
		this.departmentList=departmentList;
	}
	
	public String getName(){
		return this.name;
	}
	
	public void addDepartment(Department newDepartment){
		departmentList.add(newDepartment);
	}
	
	public ArrayList<Department> getDepartmentList(){
		return departmentList;
	}

	@Override
	public int compareTo(College o) {
		return o.getName().compareTo(this.getName());
	}
}
