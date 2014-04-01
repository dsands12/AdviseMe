package webapp.serviceServlets;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.xmpp.JID;
import com.google.appengine.api.xmpp.Message;
import com.google.appengine.api.xmpp.MessageBuilder;
import com.google.appengine.api.xmpp.SendResponse;
import com.google.appengine.api.xmpp.XMPPService;
import com.google.appengine.api.xmpp.XMPPServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import webapp.datastoreObjects.*;

public class chatServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String strCallResult = "";
		resp.setContentType("text/plain");
		XMPPService xmpp = null;
		JID fromJid = null;
		try{
			xmpp = XMPPServiceFactory.getXMPPService();
			Message msg = xmpp.parseMessage(req);
			fromJid = msg.getFromJid();
			String msgBody = msg.getBody();
			String strCommand = msgBody;
			if(strCommand==null){
				throw new Exception("You must give a command.");
			}
			strCommand=strCommand.trim();
			if(strCommand.length()==0){
				throw new Exception("You must give a command.");
			}
			String[] words = strCommand.split("@");
			if(words.length>=1){
//Command == help
				if(words[0].equalsIgnoreCase("help")){
					StringBuffer SB = new StringBuffer();
					SB.append("*****Help*****"+"\n");
					SB.append("Valid Commands include:"+"\n");
					SB.append("help,about,addcourse,getuser,resetcourserating."+"\n");
					strCallResult = SB.toString();
					
				}else if(words[0].equalsIgnoreCase("about")){
					StringBuffer SB = new StringBuffer();
					SB.append("This is AdviseMe Bot 2014"+"\n");
					SB.append("My master, Jason Anthraper made me smart!"+"\n");
					SB.append("Type help to see a list of commands!"+"\n");
					strCallResult = SB.toString();
//Command == addcourse
				}else if(words[0].equalsIgnoreCase("addcourse")){
					String[]courseInfo = words[1].split("#");
					boolean flag = addCourse(courseInfo[0],courseInfo[1],courseInfo[2],courseInfo[3],courseInfo[4],courseInfo[5],courseInfo[6]);
					if(flag){
						strCallResult = "Course Successfully Added/Changed!";
					}else{
						strCallResult = "You done goofed. Something happened. Blame Jason.";
					}
//Command == getuser
				}else if(words[0].equalsIgnoreCase("getuser")){
					//send back user info
					String[] userInfo = words[1].split("#");
					if(userInfo.length>1){
						String result = getUserInfo(userInfo[0],userInfo[1]);
						if(result==null){
							strCallResult = "User not found.";
						}else{
							strCallResult = result;
						}
					}else{
						String result = getUserInfo(userInfo[0]);
						if(result==null){
							strCallResult = "User not found.";
						}else{
							strCallResult = result;
						}
					}
//Command == resetcourserating
				}else if(words[0].equalsIgnoreCase("resetcourserating")){
					boolean flag = resetCourseRating(words[1]);
					if(flag){
						strCallResult = "Course Rating was Reset Successfully!";
					}else{
						strCallResult = "You done goofed. Something happened. Blame Jason.";
					}
				}else{
					strCallResult = "I don't understand what you are telling me!";
				}
			}
			boolean messageSent = false;
			Message replyMessage = new MessageBuilder().withRecipientJids(fromJid).withBody(strCallResult).build();
			SendResponse status = xmpp.sendMessage(replyMessage);
			messageSent = (status.getStatusMap().get(fromJid) == SendResponse.Status.SUCCESS);
			
		}catch (Exception ex){
			Message replyMessage = new MessageBuilder().withRecipientJids(fromJid).withBody("Could not understand what you sent!").build();
			boolean messageSent = false;
			SendResponse status = xmpp.sendMessage(replyMessage);
			messageSent = (status.getStatusMap().get(fromJid) == SendResponse.Status.SUCCESS);
		}
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	public boolean addCourse(String courseName,String courseTitle,String courseDescription,String upperDivision,String professorList, String semesterTaught, String textbooks){
		ObjectifyService.register(Course.class);
		if(courseName==null||courseName.isEmpty()){
			return false;
		}
		if(courseTitle==null||courseTitle.isEmpty()){
			return false;
		}
		if(courseDescription==null||courseDescription.isEmpty()){
			return false;		
		}
		if(upperDivision==null||upperDivision.isEmpty()){
			return false;		
		}
		if(professorList==null||professorList.isEmpty()){
			return false;		
		}
		if(semesterTaught==null||semesterTaught.isEmpty()){
			return false;		
		}
		if(textbooks==null||textbooks.isEmpty()){
			return false;	
		}
		List<Course> courseList=ObjectifyService.ofy().load().type(Course.class).list();
		Collections.sort(courseList);
		boolean upper;
		if(upperDivision.equals("upper")){
			upper = true;
		}else{
			upper=false;
		}
		Course course = new Course(courseName,courseTitle,courseDescription,upper);
		//TODO: Need to parse the list correctly and add the professors correctly
		course.getProfessorList().add(professorList);
		course.getSemesterTaught().add(semesterTaught);
		course.getTextbooks().add(textbooks);
		ofy().save().entity(course).now();
		return true;
	}
	
	public boolean resetCourseRating(String courseName){
		ObjectifyService.register(Course.class);
		if(courseName==null||courseName.isEmpty()){
			return false;
		}
		List<Course> courses = ObjectifyService.ofy().load().type(Course.class).list();
		for(Course course: courses){
			if(course.getCourseName().equals(courseName)){
				course.setRating(new Double(0), new Integer(0));
				ofy().save().entity(course).now();
				return true;
			}
		}
		return false;
	}
	
	public String getUserInfo(String firstName, String lastName){
		ObjectifyService.register(User.class);
		if(firstName==null||lastName==null||firstName.isEmpty()||lastName.isEmpty()){
			return null;
		}
		String result=null;
		List<User> users = ObjectifyService.ofy().load().type(User.class).list();
		for(User user: users){
			if(user.getFullName().equalsIgnoreCase(firstName + " " + lastName)){
				StringBuffer SB = new StringBuffer();
				SB.append("Facebook ID: " + user.getfbUserId()+"\n");
				SB.append("Full Name: " + user.getFullName()+"\n");
				SB.append("Email : " + user.getUserEmail()+"\n");
				SB.append("Logged In?: " + user.getLoginStatus()+"\n");
				SB.append("User Class List : " + user.getUserClassList().toString()+"\n");
				result = SB.toString();
			}
		}
		return result;
	}
	
	public String getUserInfo(String fbID){
		ObjectifyService.register(User.class);
		String result = null;
		List<User> users = ObjectifyService.ofy().load().type(User.class).list();
		for(User user: users){
			if(user.getfbUserId().equals(fbID)){
				StringBuffer SB = new StringBuffer();
				SB.append("Facebook ID: " + user.getfbUserId()+"\n");
				SB.append("Full Name: " + user.getFullName()+"\n");
				SB.append("Email : " + user.getUserEmail()+"\n");
				SB.append("Logged In?: " + user.getLoginStatus()+"\n");
				SB.append("User Class List : " + user.getUserClassList().toString()+"\n");
				result = SB.toString();
			}
		}
		return result;
	}
}