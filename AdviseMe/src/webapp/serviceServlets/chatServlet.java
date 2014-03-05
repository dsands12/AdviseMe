package webapp.serviceServlets;

import java.io.IOException;

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
			String[] words = strCommand.split(" ");
			if(words.length==1){
				if(words[0].equalsIgnoreCase("help")){
					StringBuffer SB = new StringBuffer();
					SB.append("******Help*******");
					SB.append("you asked for help.");
					SB.append("you will get no help");
					strCallResult = SB.toString();
				}else{
					strCallResult = "Sorry! I don't understand english.";
				}
			}
			boolean messageSent = false;
			Message replyMessage = new MessageBuilder().withRecipientJids(fromJid).withBody(strCallResult).build();
			SendResponse status = xmpp.sendMessage(replyMessage);
			messageSent = (status.getStatusMap().get(fromJid) == SendResponse.Status.SUCCESS);
		}catch (Exception ex){
			Message replyMessage = new MessageBuilder().withRecipientJids(fromJid).withBody("Could not understand dis english.").build();
			boolean messageSent = false;
			SendResponse status = xmpp.sendMessage(replyMessage);
			messageSent = (status.getStatusMap().get(fromJid) == SendResponse.Status.SUCCESS);
		}
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}