<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator

--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.InstaGeezAnA.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>InstaGeezAnA</title>
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
    </head>
    <body>        
                <div id="navbar" class="navbar navbar-inverse navbar-static-top">
                    <div class="container">
                      <!-- Brand and toggle get grouped for better mobile display -->
                      <div id="navHead" class="navbar-header">
                        <a id="brand" class="navbar-brand" href="/InstaGeezAnA/">InstaGeezAnA</a>
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
                                <li><a href="/InstaGeezAnA/Upload">Upload</a></li>
                                <li><a href="/InstaGeezAnA/Images/<%=UserName%>">Images</a></li>
                                <li><a href="/InstaGeezAnA/Profile/<%=UserName%>">Profile</a></li>
                              </ul>
                              <ul id="rightnav" class="nav navbar-nav navbar-right">
                                <li>
                                    <form method="POST" role="search" action="Search">
                                        <div id="searchBar">
                                            <div id="searchFormGroup" class="form-group">
                                                <input type="text" class="form-control" placeholder="Search" name="searchContent">
                                            </div>
                                            <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
                                        </div>
                                    </form>
                                </li>
                                <li><a href="/InstaGeezAnA/Logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                              </ul>
                              <%}
                              }else{
                              %>
                                <ul id="rightnav" class="nav navbar-nav navbar-right">
                                    <li><a href="/InstaGeezAnA/Register"><span class="glyphicon glyphicon-user"></span> SignUp</a></li>
                                    <li><a href="/InstaGeezAnA/Login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
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
                            InstaGeezAnA
                        </h1>
                        <br>
                            <h2 id='TaglineText'>
                                Where Pictures Come to Die.
                            </h2>
                        <%
                              if(lg == null)
                              {
                              %>
                        <a href="/InstaGeezAnA/Register"><button id="animBtn" type="button" class="btn btn-transparent wow slideInLeft">Sign Up</button></a>
                        <%}%>
                    </div>
                </div>
    </body>
</html>
