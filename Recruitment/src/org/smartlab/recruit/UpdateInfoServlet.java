package org.smartlab.recruit;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
			Map<String,String> bhavanlist = new HashMap<String,String>();
			bhavanlist.put("1", "RAM");
			bhavanlist.put("2", "BUDH");
			bhavanlist.put("3", "KRISHNA");
			bhavanlist.put("4", "GANDHI");
			bhavanlist.put("5", "SHANKAR");
			bhavanlist.put("6", "VYAS");
			bhavanlist.put("7", "VISHWAKARMA");
			bhavanlist.put("8", "BHAGIRATH");
			bhavanlist.put("9", "ASHOK");
			bhavanlist.put("10", "RANAPRATAP");
			bhavanlist.put("11", "MALAVIYA");
			bhavanlist.put("12", "MEERA");

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
				entity.setProperty("first-name", req.getParameter("name"));
				entity.setProperty("last-name", req.getParameter("last-name"));
				entity.setProperty("email", req.getParameter("email"));
				entity.setProperty("room",req.getParameter("room"));
				String bid = req.getParameter("bhavan");
				entity.setProperty("bhavan", bhavanlist.get(bid));
				
				entity.setProperty("id", req.getParameter("id"));				
				entity.setProperty("phone", req.getParameter("phone"));
				datastore.put(entity);
			}
			else
			{
				entity = new Entity("userInfo",key);				
				entity.setProperty("first-name", req.getParameter("name"));
				entity.setProperty("last-name", req.getParameter("last-name"));
				entity.setProperty("email", req.getParameter("email"));
				entity.setProperty("room",req.getParameter("room"));
				String bid = req.getParameter("bhavan");
				entity.setProperty("bhavan", bhavanlist.get(bid));
				
				entity.setProperty("id", req.getParameter("id"));				
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
