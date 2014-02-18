package webapp.datastoreObjects;

import java.util.ArrayList;

public class College {
	private ArrayList<Department> departmentList;
	
	private College(){
		departmentList = new ArrayList<Department>();
	}
	
	public College(ArrayList<Department> departmentList){
		this.departmentList = departmentList;
	}
	
	public void addDepartment(Department newDepartment){
		departmentList.add(newDepartment);
	}
	
	public ArrayList<Department> getDepartmentList(){
		return departmentList;
	}
}
