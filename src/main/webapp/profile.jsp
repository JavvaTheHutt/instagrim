<%-- 
    Document   : profile
    Created on : 11-Oct-2015, 22:18:21
    Author     : MatthewLang
--%>

<%@page import="java.util.Iterator"%>
<%@page import="uk.ac.dundee.computing.aec.InstaGeezAnA.stores.Pic"%>
<%@page import="uk.ac.dundee.computing.aec.InstaGeezAnA.stores.Avatar"%>
<%@page import="uk.ac.dundee.computing.aec.InstaGeezAnA.stores.ProfileBean"%>
<%@page import="uk.ac.dundee.computing.aec.InstaGeezAnA.stores.LoggedIn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <% LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
           session.setAttribute("username", lg.getUsername());
           ProfileBean profile = (ProfileBean) session.getAttribute("ProfileBean");
        %>
        <title>InstaGeezAnA</title>
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
                      <ul class="nav navbar-nav">
                        <li><a href="/InstaGeezAnA/Upload">Upload</a></li>
                        <li><a href="/InstaGeezAnA/Images/<%=lg.getUsername()%>">Images</a></li>
                        <li class="active"><a href="/InstaGeezAnA/Profile/<%=lg.getUsername()%>">Profile</a></li>
                      </ul>
                      <ul id="rightnav" class="nav navbar-nav navbar-right">
                        <li>
                            <form method="POST" role="search" action="/InstaGeezAnA/Search">
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
              </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
          </div>
                              
        <div class="container">              
            <div id="profileContent" class="row">
                <div id="profileBox" class="container">
                        <div class="col-md-4">
                            <ul>
                                <div id="profilePic">
                                    <% if(profile.getAvatar() != null)
                                        {%>
                                            <li id="avatar"><a href="/InstaGeezAnA/Image/<%=profile.getAvatar().getSUUID()%>"><img id="avatarImg" class="img-responsive" src="/InstaGeezAnA/Image/<%=profile.getAvatar().getSUUID()%> "></a><a id="uploadText" href="/InstaGeezAnA/UploadProfile">Change Avatar <span class="glyphicon glyphicon-cloud-upload"></span></a></li><br/>
                                    <% }else{ 
                                    %>
                                            <li id="avatar"><img class="img-responsive" id="avatarImg" src="/InstaGeezAnA/images/Vendetta.jpg"><a id="uploadText" href="/InstaGeezAnA/UploadProfile">Change Avatar <span class="glyphicon glyphicon-cloud-upload"></span></a></li>
                                    <%}%>
                                </div>
                            </ul>
                        </div>
                        <div class="col-md-4">
                            <ul>
                                <h4 class="h4">Name:</h4>
                                        <li id="avatar"><%=profile.getFirstName() + " " + profile.getLastName()%></li>
                                <h4 class="h4">Username:</h4>
                                        <li id="avatar"><%=profile.getUsername()%></li>
                                <h4 class="h4">Email:</h4>        
                                        <li id="avatar"><%=profile.getEmail()%></li>
                                <h4 class="h4">Address:</h4>        
                                        <li id="avatar"><%=profile.getAddress()%></li>
                            </ul>
                        </div>
                        <div class="col-md-4">
                            <h3 class="h3">About</h3>
                            <%if(profile.getAbout() !=null)
                            {%>
                            <p><%=profile.getAbout()%></p>
                            <%}%>
                            <%if(profile.getUsername().equals(lg.getUsername())){%>
                            <a href="/InstaGeezAnA/Update/<%=lg.getUsername()%>">update profile</a>
                            <%}%>
                        </div>
                    </div>
           </div>
        </div>
        <div class="container">              
            <div id="RecentPictures" class="row">
                <div id="profileBox" class="container">  
                        <%
                            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
                            if (lsPics == null) {
                        %>
                        <div class="col-md-6 col-md-offset-3">
                        <h3 class="h3">Recent Pictures</h3>
                        <p>No Pictures found</p>
                        </div>
                        <%
                        } else {
                                %><h3 class="h3">Recent Pictures</h3> <a href="/InstaGeezAnA/Image/<%=profile.getUsername() %>">All Images</a>
                            Iterator<Pic> iterator;
                            iterator = lsPics.iterator();
                            while (iterator.hasNext()) {
                                Pic p = (Pic) iterator.next();

                        %>
                        <div class="col-md-4">
                        <a href="/InstaGeezAnA/Image/<%=p.getSUUID()%>" ><img id="userImage" src="/InstaGeezAnA/Image/<%=p.getSUUID()%>"></a>
                        </div>
                        <%}}%>   
                </div>
           </div>
       </div>
    </body>
</html>
