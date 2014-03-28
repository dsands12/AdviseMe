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
				//Command == Help
				if(words[0].equalsIgnoreCase("help")){
					StringBuffer SB = new StringBuffer();
					SB.append("******Help*******");
					SB.append("you asked for help.");
					SB.append("you will get no help");
					strCallResult = SB.toString();
				//Command == addcourse
				}else if(words[0].equalsIgnoreCase("addcourse")){
					String[]courseInfo = words[1].split("#");
					boolean flag = addCourse(courseInfo[0],courseInfo[1],courseInfo[2],courseInfo[3],courseInfo[4],courseInfo[5],courseInfo[6]);
					if(flag){
						strCallResult = "Course Successfully Added/Changed!";
					}else if(words[0].equalsIgnoreCase("getuser")){
						
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
	
	static{ObjectifyService.register(Course.class);}
	public boolean addCourse(String courseName,String courseTitle,String courseDescription,String upperDivision,String professorList, String semesterTaught, String textbooks){
				
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
		List<Course> schoolList=ObjectifyService.ofy().load().type(Course.class).list();
		Collections.sort(schoolList);
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
}