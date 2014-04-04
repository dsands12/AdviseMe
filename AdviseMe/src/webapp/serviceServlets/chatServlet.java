package webapp.serviceServlets;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import webapp.datastoreObjects.Course;
import webapp.datastoreObjects.User;

import com.google.appengine.api.xmpp.JID;
import com.google.appengine.api.xmpp.Message;
import com.google.appengine.api.xmpp.MessageBuilder;
import com.google.appengine.api.xmpp.SendResponse;
import com.google.appengine.api.xmpp.XMPPService;
import com.google.appengine.api.xmpp.XMPPServiceFactory;
import com.googlecode.objectify.ObjectifyService;

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
					SB.append("help" + "\n");
					SB.append("about" + "\n");
					SB.append("addcourse" + "\n");
					SB.append("getuser" + "\n");
					SB.append("resetcourserating" + "\n");
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
					System.out.println("Before");
					boolean flag = resetCourseRating(words[1]);
					System.out.println("After");
					if(flag){
						strCallResult = "Course Rating was Reset Successfully!";
					}else{
						strCallResult = "You done goofed. Something happened. Blame Jason.";
					}
				}else{
					strCallResult = "I don't understand what you are telling me!";
				}
			}
			Message replyMessage = new MessageBuilder().withRecipientJids(fromJid).withBody(strCallResult).build();
			SendResponse status = xmpp.sendMessage(replyMessage);
			status.getStatusMap().get(fromJid);
			
		}catch (Exception ex){
			System.out.println(ex.getMessage());
			Message replyMessage = new MessageBuilder().withRecipientJids(fromJid).withBody(ex.getMessage()).build();
			SendResponse status = xmpp.sendMessage(replyMessage);
			status.getStatusMap().get(fromJid);
		}
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	public boolean addCourse(String courseName,String courseTitle,String courseDescription,String upperDivision,String professorList, String semesterTaught, String prereqs){
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
		if(prereqs==null||prereqs.isEmpty()){
			return false;	
		}
		boolean upper;
		if(upperDivision.equals("upper")){
			upper = true;
		}else{
			upper=false;
		}
		Course course = new Course(courseName,courseTitle,courseDescription,upper);
		if(professorList.isEmpty()||professorList==null||professorList.equalsIgnoreCase("none")){
		course.getProfessorList().add("None");	
		}else{
			String[] temp = professorList.split("&");
			for(int i=0;i<temp.length;i++){
				course.getProfessorList().add(temp[i]);
			}
		}
		if(semesterTaught.isEmpty()||semesterTaught==null||semesterTaught.equalsIgnoreCase("none")){
		course.getSemesterTaught().add("None");	
		}else{
			String[] temp = semesterTaught.split("&");
			for(int i=0;i<temp.length;i++){
				course.getSemesterTaught().add(temp[i]);
			}
		}
		if(prereqs.isEmpty()||prereqs==null||prereqs.equalsIgnoreCase("none")){
		course.getPrereq().add("None");	
		}else{
			String[] temp = prereqs.split("&");
			for(int i=0;i<temp.length;i++){
				String[] temp2 = temp[i].split(",");
				String toadd = temp2[0];
				for(int k=1;k<temp2.length;k++){
					toadd+=" or " + temp2[k];
				}
				course.getPrereq().add(toadd);
			}
		}
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
				course.resetRating();
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