<%-- 
    Document   : login.jsp
    Created on : Sep 28, 2014, 12:04:14 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.InstaGeezAnA.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>InstaGeezAnA</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />

    </head>
    <body>
        <header>
        <h1>InstaGeezAnA ! </h1>
        <h2>Your world in Black and White</h2>
        <%
                if(null != session.getAttribute("DisplayMessage"))
                {
                    %>
        <p> Message: ${DisplayMessage}</p>
        <%
                    session.setAttribute("DisplayMessage", null);
                }%>
        </header>
        <nav>
            <ul>
                
                <li><a href="/InstaGeezAnA/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
       
        <article>
            <h3>Login</h3>
            <form method="POST"  action="Login">
                <ul>
                    <li>User Name <input type="text" name="username"></li>
                    <li>Password <input type="password" name="password"></li>
                </ul>
                <br/>
                <input type="submit" value="Login"> 
            </form>

        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/InstaGeezAnA">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
