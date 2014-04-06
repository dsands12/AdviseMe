package webapp.serviceServlets;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class emailServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		try{
			Properties props = new Properties();
			Session session = Session.getDefaultInstance(props, null);
			MimeMessage message = new MimeMessage(session, req.getInputStream());
			Address[] fromAddresses = message.getFrom();
			String strCallResult ="";
			try{
				strCallResult = "Sorry, This email address is automated.";
				Message msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress("utadviseme@gmail.com", "Advise Me Automated Email"));
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(fromAddresses[0].toString()));
				msg.setSubject("Error");
				msg.setText(strCallResult);
				Transport.send(msg);
			}catch(Exception e){
				Message msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress("utadviseme@gmail.com", "Advise Me Automated Email"));
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(fromAddresses[0].toString()));
				msg.setSubject("Error");
				msg.setText("Something wrong happened:(");
				Transport.send(msg);
			}
		}catch(Exception e){/*Some exception occurred. Send email to admin*/
			Properties props = new Properties();
			Session session = Session.getDefaultInstance(props,null);
			String address = "Jason.Anthraper@utexas.edu";
			Message msg = new MimeMessage(session);
			try{
				msg.setFrom(new InternetAddress("Error@advisemeut.appspotmail.com", "WebAppBlog Error"));
				msg.addRecipient(Message.RecipientType.TO,new InternetAddress(address));
				msg.setSubject("Error When Sending Subscriber Email");
				msg.setText("Error.");
				Transport.send(msg);
			}catch(Exception e1){}
		}
	}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		doPost(req,resp);
	}
}
