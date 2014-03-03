package webapp.addServlets;

import webapp.datastoreObjects.User;

import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class addFBUserServlet extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String FBId = req.getParameter("id");
		String FBFirst = req.getParameter("firstname");
		String FBLast = req.getParameter("lastname");
		String FBEmail = req.getParameter("email");
		String remoteAddr = req.getRemoteAddr();
		String challenge = req.getParameter("recaptcha_challenge_field");
		String response = req.getParameter("recaptcha_response_field");
		ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
		reCaptcha.setPrivateKey("6LfFIe8SAAAAADGueFM28Toq3H3OJWqB2xTpoj-A");
		ReCaptchaResponse reCaptchaReponse = reCaptcha.checkAnswer(remoteAddr, challenge, response);
		if(!reCaptchaReponse.isValid()){
			//TODO: call error page correctly
			resp.sendRedirect("/error.jsp");
		}else{
			User user;
			if(FBId==null||FBId.isEmpty()){
				//TODO: call error page
				resp.sendRedirect("/error.jsp");
			}
			if(FBFirst==null||FBId.isEmpty()){
				//TODO: call error page
				resp.sendRedirect("/error.jsp");
			}
			if(FBLast==null||FBLast.isEmpty()){
				//TODO: call error page
				resp.sendRedirect("/error.jsp");
			}
			if(FBEmail==null||FBId.isEmpty()){
				user = new User(FBId,FBFirst,FBLast);
				user.setLoginStatus(true);
			}else{
				user = new User(FBId,FBFirst,FBLast,FBEmail);
				user.setLoginStatus(true);
			}
			ofy().save().entity(user).now();
			resp.sendRedirect("/addusercourses.jsp");
		}
	}
}
