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
        <link rel="stylesheet" href="/InstaGeezAnA/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="/InstaGeezAnA/bootstrap/css/styles.css"/>
        <link href="/InstaGeezAnA/bootstrap/css/font-awesome.min.css" rel="stylesheet">
        <link href="/InstaGeezAnA/bootstrap/css/animate.min.css" rel="stylesheet">
        <link href="/InstaGeezAnA/bootstrap/css/prettyPhoto.css" rel="stylesheet">
        <link href="/InstaGeezAnA/bootstrap/css/main.css" rel="stylesheet">
        <link href="/InstaGeezAnA/bootstrap/css/responsive.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="/InstaGeezAnA/bootstrap/js/bootstrap.min.js"></script>
        <script src="/InstaGeezAnA/bootstrap/js/jquery.prettyPhoto.js"></script>
        <script src="/InstaGeezAnA/bootstrap/js/jquery.isotope.min.js"></script>
        <script src="/InstaGeezAnA/bootstrap/js/main.js"></script>
        <script src="/InstaGeezAnA/bootstrap/js/wow.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>InstaGeezAnA</title>
        

    </head>
    <body>
        <header>
        <h1>InstaGeezAnA ! </h1>
        <h2>Your world in Black and White</h2>
        </header>
       
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
