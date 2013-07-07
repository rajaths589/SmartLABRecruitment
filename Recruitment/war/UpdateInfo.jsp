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

<% 
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	boolean user_null = (user==null);
	
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
	
	boolean recordExists = (entity==null);
%>
<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/htm; charset=utf-8" />
    <title>SmartLAB - UpdateInfo</title>
    <link rel="stylesheet" type="text/css" media="screen" href="./updateInfoFiles/reset.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="./updateInfoFiles/960.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="./updateInfoFiles/global.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="./updateInfoFiles/typography.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="./updateInfoFiles/structure.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="./updateInfoFiles/menu.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="./updateInfoFiles/forms.css" />
	
</head>

<body>
<div id="bg">
	<div id="page-header">
    	<div class="container_12">
        	<div class="grid_12">
            	<a href="./welcome.jsp"><img src="./welcome_files/logo-banner.jpg" height="156" width="924" alt="SmartLAB" /></a>
        	</div>
    	</div>
	</div>
	
	<div id="main">
    	<div class="container_12">
			<div id="main-menu" class="grid_3">
            	<ul id="main-menu-list">
<%
	if(user_null)
	{
%>
                	<li id="menu-login"><a href="<%=userService.createLoginURL(request.getRequestURI())%>">Login</a></li>
<% }else{ %>
			    	<li id="menu-login"><a href="<%=userService.createLogoutURL(request.getRequestURI())%>">Logout</a></li>
<%}%>
                	<li id="menu-about"><a href="javascript:void(0)">About</a></li>                	                	
                	<li id="menu-events"><a href="javascript:void(0)">Events &amp; Updates</a></li>
                	<li id="menu-connect"><a href="javascript:void(0)">Contact Us</a></li>                	
            	</ul>
        	</div>
		<div class="grid_9">
            <div class="content">
            
                <h1 id="main-page-title">Update your Information</h1>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod volutpat tellus, vel dapibus 
                nibh sagittis nec. Vestibulum lectus arcu, aliquam ac elementum a, porttitor lacinia augue. Cras eu ante 
                nec ipsum ultricies consequat imperdiet vitae lacus. Sed nec neque eget mi scelerisque aliquam. Curabitur 
                porttitor tempor interdum.</p>
				
				<form action="/updateInfo.jsp" method="post" id="form" class="form-register">
					<div id="loggedin-message" class="loggedin">
<% if(!user_null){%>
            	        <p><strong>You are logged in as <em>${fn:escapeXml(user.email)}!</em>.</strong> <a href="<%=userService.createLogoutURL(request.getRequestURI())%>">(Not you?)</a></p>
<%}else{%>
						<p><strong>You are not logged in.Please Login to continue </em>.</strong> <a href="<%=userService.createLoginURL(request.getRequestURI())%>">(Login)</a></p>
<%}%>			            	       
            	    </div>

					<h2 id="form-register-title">Update Information</h2> <p id="form-register-req" class="req">* fields required</p>
					
						<fieldset id="form-register-fieldset-basicinfo" class="fieldset-basicinfo">
<% if(recordExists){%>
			    			<legend><span>Personal Information</span></legend>
                			<div id="form-row-fname" class="row fname">
                				<label>First Name<span class="req">*</span></label>
                				<input type="text" name="fname" value="<%=entity.getProperty("first-name")%>" class="text" />
                			</div>
                			<div id="form-row-lname" class="row lname">
	                			<label>Last Name<span class="req">*</span></label>
                				<input type="text" name="lname" value="<%=entity.getProperty("last-name")%>" class="text" />
                			</div>
							<div id="form-row-email" class="row email error">
                				<label>Email Address<span class="req">*</span></label>
                				<input type="text" name="email" value="<%=entity.getProperty("email")%>" class="text" />
								<div class="error-message">*Enter a valid email address</div>
                			</div>
                			<div id="form-row-phone" class="row phone">
	                			<label>Phone Number<span class="req">*</span></label>
    	            			<input type="text" name="phone" value="<%=entity.getProperty("phone")%>" class="text" />
        	        		</div>
							<div id="form-row-bday" class="row bday">
	                			<label>ID Number<span class="req">*</span></label>
    	            			<input type="text" name="id" value="<%=entity.getProperty("id")%>" class="text" />
        	        		</div>
<%}else{%>
			    			<legend><span>Personal Information</span></legend>
                			<div id="form-row-fname" class="row fname">
                				<label>First Name<span class="req">*</span></label>
                				<input type="text" name="fname" value="" class="text" />
                			</div>
                			<div id="form-row-lname" class="row lname">
	                			<label>Last Name<span class="req">*</span></label>
                				<input type="text" name="lname" value="" class="text" />
                			</div>
							<div id="form-row-email" class="row email error">
                				<label>Email Address<span class="req">*</span></label>
                				<input type="text" name="email" value="" class="text" />
								<div class="error-message">*Enter a valid email address</div>
                			</div>
                			<div id="form-row-phone" class="row phone">
	                			<label>Phone Number<span class="req">*</span></label>
    	            			<input type="text" name="phone" value="" class="text" />
        	        		</div>
							<div id="form-row-bday" class="row bday">
	                			<label>ID Number<span class="req">*</span></label>
    	            			<input type="text" name="id" value="" class="text" />
        	        		</div>
<%}%>            	    	
                		</fieldset>

	                	<fieldset id="form-register-fieldset-address" class="fieldset-address">
						    <legend><span>Address Information</span></legend>
							<div id="form-row-zip" class="row zip error">
                				<label>Room Number<span class="req">*</span></label>
                				<input type="text" name="room" value="" class="text" />
								<div class="error-message">*Enter your Room number</div>
                			</div>
							<div id="form-row-country" class="row country error">
                    			<select name="bhavan">
                    				<option selected="selected" disabled="disabled">Bhavan</option>
                    				<option value="1">RM</option>
                    				<option value="2">BD</option>
                    				<option value="3">KR</option>
                    				<option value="4">GN</option>
                    				<option value="5">SK</option>
                    				<option value="6">VY</option>
                    				<option value="7">VK</option>
                    				<option value="8">BG</option>
                    				<option value="9">AK</option>
                    				<option value="10">RP</option>
                    				<option value="11">ML</option>
                    				<option value="12">Meera</option>                    				
                    			</select><span class="req">*</span>
								<div class="error-message">*Select a Bhavan</div>
                			</div>

                		</fieldset>
	
    	            	<fieldset id="form-register-fieldset-school" class="fieldset-school">
						    <legend><span>Experience</span></legend>
			    				<div id="form-row-gradyear" class="row schoolname error">
                	    			<label>Describe your Programming Experience<span class="req">*</span></label>
                					<textarea  name="progexp" value="" class="text"></textarea>
								</div>
								<div id="form-row-gradyear" class="row schoolname error">
                	    			<label>Describe your Electronics Experience<span class="req">*</span></label>
                					<textarea  name="eeexp" value="" class="text"></textarea>
								</div>
						</fieldset>
						
			            	    <div id="form-register-fieldset-button-row" class="row button-row">
            		    <input id="form-register-submit" type="submit" value="Submit" class="submit" />
                    </div>
            	</form>
            	<!-- end form -->
    
            </div>
            <!-- .content -->
        </div>
        <!-- .grid_9 -->
        <!-- 
        ////////////////////////
           END PAGE CONTENT
        ////////////////////////
        -->

    </div>
    <!-- .container_12 -->
</div>
</body>
</html>