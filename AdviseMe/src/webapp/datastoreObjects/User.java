package webapp.datastoreObjects;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class User {
	@Id String name = "No username entered.";
	
	@SuppressWarnings("unused")
	private User(){}
	
	public User(String name){
		this.name=name;
	}
	
	public String getUsername(){
		return this.name;
	}
}
