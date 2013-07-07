<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">
	<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    	<title>SmartLAB BITS Pilani</title>
    	<link rel="stylesheet" type="text/css" media="screen" href="./welcome_files/reset.css">
    	<link rel="stylesheet" type="text/css" media="screen" href="./welcome_files/960.css">
    	<link rel="stylesheet" type="text/css" media="screen" href="./welcome_files/global.css">
    	<link rel="stylesheet" type="text/css" media="screen" href="./welcome_files/typography.css">
    	<link rel="stylesheet" type="text/css" media="screen" href="./welcome_files/structure.css">
    	<link rel="stylesheet" type="text/css" media="screen" href="./welcome_files/menu.css">
	</head>
	
	<body>
		<div id="bg">
			<div id="page-header">
    			<div class="container_12">
        			<div class="grid_12">            
            			<a href="./welcome_files/welcome.html"><img src="./welcome_files/logo-banner.jpg" height="156" width="924" alt="SmartLAB BITS Pilani"></a>
        			</div>
    			</div>
			</div>
		
			<div id="main">
		    	<div class="container_12">
		    		<div id="main-menu" class="grid_3">
            			<ul id="main-menu-list">
            				<% 
            					UserService userService1 = UserServiceFactory.getUserService();
                    			User user1 = userService1.getCurrentUser();
                    			if(user1!=null)
                    			{
                   					pageContext.setAttribute("user", user1);                   				
                   			%>	                			
                   			<li id="menu-login"><a href="<%=userService1.createLogoutURL(request.getRequestURI())%>">Logout</a></li>
                			<%}else{%>
                			<li id="menu-login"><a href="<%=userService1.createLoginURL(request.getRequestURI())%>">Login</a></li>
                			<%}%>
                			<li id="menu-about"><a href="javascript:void(0)">About</a></li>
                			<li id="menu-apply"><a href="./UpdateInfo.jsp">Update Information</a></li>
							<li id="menu-show"><a href="javascript:void(0)">Show Profile</a></li>
                			<li id="menu-events"><a href="javascript:void(0)">Events &amp; Updates</a></li>
                			<li id="menu-connect"><a href="javascript:void(0)">Contact </a></li>
            			</ul>
        			</div>
        		
	        		<div class="grid_9">
    	    			<div class="content">
        					<div id="user-login">
            	        		<% 
                	    			UserService userService = UserServiceFactory.getUserService();
                    				User user = userService.getCurrentUser();
                    				if(user!=null)
                    				{
                    					pageContext.setAttribute("user", user);
                    			%>				
                    			<p>You are signed in as ${fn:escapeXml(user.email)}! <a href="<%= userService.createLogoutURL(request.getRequestURI())%>">(Logout)</a></p>
                    			<%}%>                    	                    		
                			</div>	
						
							<div id="how-it-works" class="block full home-block-1">
                    			<h2 id="title-section-how-it-works">SmartLAB Recruitment 2013</h2>
                        
                    			<div id="block-how-it-works-description" class="description">
                        			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris nec lectus lacus, a blandit ante. Sed lorem ipsum, 
                        			aliquam ac tincidunt ac, luctus ut felis. Sed lobortis dapibus semper. Sed lorem ipsum, aliquam ac tincidunt ac, 
                        			luctus ut felis.</p>
                    			</div>
                			</div>
                		
                			<div class="content_column_1">                    
                    			<div id="apply-students" class="block block-students">
                        			<%
                        				if(user==null)
                        				{
                        			%>
                        			<h3 id="title-section-apply-students">Apply now!</h3>
                        			<p id="block-apply-students-text-action" class="action"><a href="<%=userService.createLoginURL(request.getRequestURI())%>">Login</a></p>
                        			<p id="block-apply-students-text-small" class="small">with a Google Account to get started.</p>
                        			<%} else {%>
                        			<h3 id="title-section-apply-students">Apply now!</h3>
                        			<p id="block-apply-students-text-action" class="action"><a href="./UpdateInfo.jsp">Update Information</a></p>
                        			<%}%>
                    			</div>                                       
                			</div>
                		
                			<div class="content_column_2">
                				<div id="connect-with-us" class="block block-connect">
                        			<h4 id="title-section-connect-with-us">Connect With Us</h4>
                        			<div id="block-connect-with-us-content" class="block-content">
                            			<a href="javascript:void(0)" id="connect-block-facebook" class="social fb">Facebook</a>
                            			<a href="javascript:void(0)" id="connect-block-twitter" class="social tw">Twitter</a>                            
                            			<a href="javascript:void(0)" id="connect-block-email" class="social em">Email</a>
                                	</div>
                    			</div>
                    		</div>
                    	
                    	</div>
             		</div>
        		</div>
        	</div>
        	<div id="footer">
    			<div class="container_12">
            		<div class="grid_3">&nbsp;</div>
            	   		<div class="grid_9">
         	        		<div class="footer-menu">
                 	   			<ul id="footer-menu-list">
                    	    		<li id="footer-menu-about"><a href="javascript:void(0)">About</a></li>
                        			<li id="footer-menu-contact"><a href="javascript:void(0)">Contact</a></li>
                        			<li id="footer-menu-facebook" class="social"><a href="javascript:void(0)" class="fb">Facebook</a></li>
                        			<li id="footer-menu-twitter" class="social"><a href="javascript:void(0)" class="tw">Twitter</a></li>                        
                        			<li id="footer-menu-email" class="social"><a href="javascript:void(0)" class="em">Email</a></li>                        
                    			</ul>
                			</div>
                			<div class="footer-meta">
                    		<span class="powered">Powered by <a href="https://developers.google.com/appengine/" target="_blank">Google AppEngine</a></span>
                		</div>
            		</div>
        		</div>
			</div>
		</div>
	</body>
</html>		