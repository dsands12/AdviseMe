package webapp.datastoreObjects;

import java.util.Date;

import com.googlecode.objectify.annotation.Embed;

@Embed
public class Comment implements Comparable<Comment>{
	String content;
	Integer rating;
	Integer number;
	Date date;
	
	private Comment(){}
	
	public Comment(String content){
		this.date = new Date();
		this.content=content;
		this.number=0;
		this.rating=0;
	}
	
	public Comment(String content, Integer rating){
		this.date= new Date();
		this.content=content;
		this.number=1;
		ratingChange(rating);
	}
	
	public void ratingChange(Integer rating){
		number+=1;
		this.rating=((this.rating+rating)/this.number);
	}
	
	@Override
	public int compareTo(Comment o) {
		// TODO Auto-generated method stub
		return 0;
	}
}
