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
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="bootstrap/css/styles.css"/>
        <link href="bootstrap/css/font-awesome.min.css" rel="stylesheet">
        <link href="bootstrap/css/animate.min.css" rel="stylesheet">
        <link href="bootstrap/css/prettyPhoto.css" rel="stylesheet">
        <link href="bootstrap/css/main.css" rel="stylesheet">
        <link href="bootstrap/css/responsive.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="bootstrap/js/jquery.prettyPhoto.js"></script>
        <script src="bootstrap/js/jquery.isotope.min.js"></script>
        <script src="bootstrap/js/main.js"></script>
        <script src="bootstrap/js/wow.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>        
                <div id="navbar" class="navbar navbar-inverse navbar-static-top">
                    <div class="container">
                      <!-- Brand and toggle get grouped for better mobile display -->
                      <div id="navHead" class="navbar-header">
                        <a id="brand" class="navbar-brand" href="/Instagrim/">Instagrim</a>
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                          <span class="sr-only">Toggle navigation</span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                        </button>
                          
                      </div>
                            

                      <!-- Collect the nav links, forms, and other content for toggling -->
                      <div class="collapse navbar-collapse">
                          <%
                              LoggedIn lg =  (LoggedIn) session.getAttribute("LoggedIn");
                              if(lg != null)
                              {
                                  String UserName = lg.getUsername();
                                  if(lg.getlogedin())
                                  {
                              %>
                              <ul class="nav navbar-nav">
                                <li><a href="upload.jsp">Upload</a></li>
                                <li><a href="/Instagrim/Images/<%=UserName%>">Your Images</a></li>
                              </ul>
                              <ul id="rightnav" class="nav navbar-nav navbar-right">
                                <li><a href="/Instagrim/Logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                              </ul>
                              <%}
                              }else{
                              %>
                                <ul id="rightnav" class="nav navbar-nav navbar-right">
                                    <li><a href="register.jsp"><span class="glyphicon glyphicon-user"></span> SignUp</a></li>
                                    <li><a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                                </ul>
                              <%
                                  }
                              %>
                      </div><!-- /.navbar-collapse -->
                    </div><!-- /.container-fluid -->
                  </div>
                <div id='header' class="jumbotron">
                    <div id="jumbotronContainer" class='container'>
                        <h1 id='WelcomeText'>
                            Instagrim
                        </h1>
                        <br>
                            <h2 id='TaglineText'>
                                Where Pictures Come to Die.
                            </h2>
                        <%
                              if(lg == null)
                              {
                              %>
                        <a href="register.jsp"><button id="animBtn" type="button" class="btn btn-transparent wow slideInLeft">Sign Up</button></a>
                        <%}%>
                    </div>
                </div>
    </body>
</html>
