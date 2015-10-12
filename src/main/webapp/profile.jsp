<%-- 
    Document   : profile
    Created on : 11-Oct-2015, 22:18:21
    Author     : MatthewLang
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
//           String userName = lg.getUsername();
           %>
        <title>Instagrim</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
