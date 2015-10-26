<%-- 
    Document   : profile
    Created on : 11-Oct-2015, 22:18:21
    Author     : MatthewLang
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.Avatar"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.ProfileBean"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/Instagrim/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="/Instagrim/bootstrap/css/styles.css"/>
        <link href="/Instagrim/bootstrap/css/font-awesome.min.css" rel="stylesheet">
        <link href="/Instagrim/bootstrap/css/animate.min.css" rel="stylesheet">
        <link href="/Instagrim/bootstrap/css/prettyPhoto.css" rel="stylesheet">
        <link href="/Instagrim/bootstrap/css/main.css" rel="stylesheet">
        <link href="/Instagrim/bootstrap/css/responsive.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="/Instagrim/bootstrap/js/bootstrap.min.js"></script>
        <script src="/Instagrim/bootstrap/js/jquery.prettyPhoto.js"></script>
        <script src="/Instagrim/bootstrap/js/jquery.isotope.min.js"></script>
        <script src="/Instagrim/bootstrap/js/main.js"></script>
        <script src="/Instagrim/bootstrap/js/wow.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <% LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
           session.setAttribute("username", lg.getUsername());
           ProfileBean profile = (ProfileBean) session.getAttribute("ProfileBean");
        %>
        <title>Instagrim</title>
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
                              <ul class="nav navbar-nav">
                                <li><a href="/Instagrim/Upload">Upload</a></li>
                                <li><a href="/Instagrim/Images/<%=lg.getUsername()%>">Images</a></li>
                                <li class="active"><a href="/Instagrim/Profile/<%=lg.getUsername()%>">Profile</a></li>
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
                                <li><a href="/Instagrim/Logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                              </ul>
                      </div><!-- /.navbar-collapse -->
                    </div><!-- /.container-fluid -->
                  </div>
                <div id="profileContent" class="row">
                    <div id="profileBox" class="container">
                        <div  class="col-md-4 col-md-offset-4">
                            <h2 class="h2">Update Profile</h2>
                            <br/>
                            <form class="form-horizontal" method="POST" action="Profile" role="form">
                                <div class="form-group">
                                    <label>First Name:</label>
                                    <input class="form-control" type="text" name="firstname" value="<%=profile.getFirstName()%>">
                                </div>
                                <div class="form-group">
                                    <label>Last Name:</label>
                                    <input class="form-control" type="text" name="lastname" value="<%=profile.getLastName()%>">
                                </div>
                                <div class="form-group">
                                    <label>Email:</label>
                                    <input class="form-control" type="email" name="email" value="<%=profile.getEmail()%>">
                                </div>
                                <div class="form-group">
                                    <label>Street:</label>
                                    <input class="form-control" type="text" name="street" value="<%=profile.getStreet()%>">
                                </div>
                                <div class="form-group">
                                    <label>City:</label>
                                    <input class="form-control" type="text" name="city" value="<%=profile.getCity()%>">
                                </div>
                                <div class="form-group">
                                    <label>PostCode:</label>
                                    <input class="form-control" type="number" name="postcode" value="<%=profile.getPostCode()%>">
                                </div>
                                <div class="form-group">
                                    <label>About:</label>
                                    <textarea class="form-control" type="text" name="about"><%=profile.getAbout()%></textarea>
                                </div>
                                    <button  type="submit" class="btn btn-primary">Update Profile</button>
                                    <input class="hidden" type="text" name="page" value="Update">
                             </form>
                        </div>                  
                    </div>
                </div>
    </body>
</html>
