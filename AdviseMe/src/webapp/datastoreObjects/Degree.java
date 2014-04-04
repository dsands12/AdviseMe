package webapp.datastoreObjects;

import java.util.ArrayList;

public class Degree {
	private String name;
	ArrayList<String> courses = new ArrayList<String>();
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
