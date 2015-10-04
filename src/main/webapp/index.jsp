<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Instagrim</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <header>
            <h1>InstaGrim ! </h1>
            <h2>Your world in GITHUB HELL!!!!!</h2>
        </header>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <ul class="nav navbar-nav">


                    <li><a href="upload.jsp">Upload</a></li>
                        <%

                            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                            if (lg != null) {
                                String UserName = lg.getUsername();
                                if (lg.getlogedin()) {
                        %>

                    <li><a href="/Instagrim/Images/<%=lg.getUsername()%>">Your Images</a></li>
                    <ul class ="nav navbar-nav navbar-right">
                        <li><a href="/Instagrim/Logout"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
                    </ul>
                        <%}
                                }else{
                                    %>
                     <li><a href="register.jsp">Register</a></li>
                    <li><a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                    <%


                        }%>
                </ul>
            </div>
        </nav>
        <footer>
            <ul>
                <li class="footer"><a href="/Instagrim">Home</a></li>
                <li>&COPY; Andy C</li>
            </ul>
        </footer>
    </body>
</html>
