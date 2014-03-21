package webapp.serviceServlets;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import webapp.datastoreObjects.*;

public class emailServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);
		try{
			MimeMessage message = new MimeMessage(session, req.getInputStream());
			Address[] fromAddresses = message.getFrom();
			String subject = message.getSubject();
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
		}catch(MessagingException e){
			//something happened.
		}
	}

}
