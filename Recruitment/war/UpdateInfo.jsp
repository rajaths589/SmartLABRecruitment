<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery.TooManyResultsException" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<style type="text/css">
			body.ss-base-body {
  				font-family: Arial,sans-serif;
			}
			div.ss-form-container {
  				padding: 15px;
  				background-color: #f7f7f7;
  				border-color: #0b61a4;
  				border-style: solid;
  				border-width: 1px;
			}
			h1.ss-form-title {
  				background-color: #0b61a4;
  				padding: 15px;
  				margin: -15px -15px 15px;
  				color: #ffffff;
  				text-align: left;
			}
			div.errorbox-bad {
  				background-color: #f7f7f7;
			}
			h2.ss-section-title {
  				background-color: transparent;
			}
			div.ss-submit div.ss-form-entry {
  				background: none;
  				border: none;
			}

		</style>

		<meta name="viewport" content="width=device-width">

		<link href="./viewform_files/2801770953-mobile_formview_ltr.css" type="text/css" rel="stylesheet" media="screen and (max-device-width: 600px)">
	</head>
	
	<body dir="ltr" class="ss-base-body">
		<div itemscope="" itemtype="">
			<meta itemprop="name" content="SmartLAB Registration">
			<meta itemprop="description" content="New User registration form">
			<div class="ss-form-container">
				<div class="ss-top-of-page">
					<div class="ss-form-heading">
						<h1 class="ss-form-title" dir="ltr">SmartLAB</h1>
						<div class="ss-form-desc ss-no-ignore-whitespace">Update Information</div>
						<hr class="ss-email-break" style="display:none;">
						<div class="ss-required-asterisk">All fields are Required</div>
					</div>
				</div>
				<% 
					UserService userService = UserServiceFactory.getUserService();
					User user = userService.getCurrentUser();
					if(user!=null)
					{
						DatastoreService dataStore = DatastoreServiceFactory.getDatastoreService();
						Key key = KeyFactory.createKey("email",user.getEmail());
						Query query = new Query("userInfo",key);
						Entity entity = null;
						try
						{
							entity = dataStore.prepare(query).asSingleEntity();
						}
						catch(TooManyResultsException e)
						{
							Logger.getLogger(this.getClass().getName()).severe("Too many objects with same key");
							System.exit(0);
						}
						if(entity!=null) 
						{
				%>
						<div class="ss-form">
							<form action="/updateInfo" method="POST" id="ss-form" target="_self" onsubmit="">
								<ol style="padding-left: 0">
									<div>Name</div>
									<div><input type="text" name="name" value="<%=entity.getProperty("name").toString()%>"></div>
									<div>ID Number</div>
									<div><input type="text" max=12 name="id" value="<%=entity.getProperty("id").toString()%>"></div>
									<div>RoomNumber/Bhavan. e.g. 403/SK </div>
									<div><input  type="text" max=6 name="addr" value="<%=entity.getProperty("addr").toString()%>"></div>																																										
									<div>Phone Number</div>
									<div><input name="phone" max=10 value="<%=entity.getProperty("phone").toString()%>"></div>
									<input type="submit" value="UpdateInfo"/>
								</ol>																										
							</form>
						</div>
				<%		}else{  %>
									<div class="ss-form">
										<form action="/updateInfo" method="POST" id="ss-form" target="_self" onsubmit="">
											<ol style="padding-left: 0">
												<div>Name</div>
												<div><input type="text" name="name"></div>
												<div>ID Number</div>
												<div><input type="text" max=12 name="id"></div>
												<div>RoomNumber/Bhavan. e.g. 403/SK </div>
												<div><input type="text" max=6 name="addr"></div>																																										
												<div>Phone Number</div>
												<div><input type="text" max=10 name="phone"></div>
												<input type="submit" value="UpdateInfo"/>
											</ol>																										
										</form>
									</div>
				<%}}else{ %>
				<p> Not Logged In. <a href="./welcome.jsp"> Back </a>
				<%}%>
				
				</div>
				</div>
				</body>
				</html> 	