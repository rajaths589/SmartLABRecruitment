<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<title>Updated</title>
</head>
<body>
<%
	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
 %>
<p>Hello,${fn:escapeXml(user.email)}!. Your information is updated. Please check the notifications page for further updates.</p>
<a href="./welcome.jsp">Go to HomePage </a>
</body>
</html>
