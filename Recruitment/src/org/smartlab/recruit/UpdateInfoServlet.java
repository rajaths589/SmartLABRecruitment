package org.smartlab.recruit;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery.TooManyResultsException;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserServiceFactory;


@SuppressWarnings("serial")
public class UpdateInfoServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		User user = UserServiceFactory.getUserService().getCurrentUser();
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		if(user!=null)
		{
			Key key = KeyFactory.createKey("email", user.getEmail());
			Query query = new Query("userInfo", key);
			Entity entity = null;
			try{
				entity = datastore.prepare(query).asSingleEntity();
			}
			catch(TooManyResultsException ex)
			{
				Logger.getLogger(UpdateInfoServlet.class.getName()).severe(ex.toString());
				System.exit(0);
			}
			if(entity!=null)
			{
				entity.setProperty("name", req.getParameter("name"));						
				entity.setProperty("id", req.getParameter("id"));
				entity.setProperty("addr", req.getParameter("addr"));
				entity.setProperty("phone", req.getParameter("phone"));
				datastore.put(entity);
			}
			else
			{
				entity = new Entity("userInfo",key);				
				entity.setProperty("name", req.getParameter("name"));						
				entity.setProperty("id", req.getParameter("id"));
				entity.setProperty("addr", req.getParameter("addr"));
				entity.setProperty("phone", req.getParameter("phone"));
				datastore.put(entity);
			}						
			resp.sendRedirect("./updated.jsp");
		}
		else
		{
			resp.sendRedirect("./welcome.jsp");
		}
	
	}

}
