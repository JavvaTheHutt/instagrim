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
        <script>
            function sessionUploadSet() {
                <%session.setAttribute("uploadProfile", true);%>
            }
        </script>
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
                                <li><a href="/Instagrim/upload.jsp">Upload</a></li>
                                <li><a href="/Instagrim/Images/<%=lg.getUsername()%>">Your Images</a></li>
                                <li class="active"><a href="/Instagrim/Profile/<%=lg.getUsername()%>">Profile</a></li>
                              </ul>
                              <ul id="rightnav" class="nav navbar-nav navbar-right">
                                <li><a href="/Instagrim/Logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                              </ul>
                      </div><!-- /.navbar-collapse -->
                    </div><!-- /.container-fluid -->
                  </div>
                              
                <div class="container">              
                <div id="profileContent" class="row">
                    <div class="col-md-3"></div>
                    <div id="profileBox" class="container">
                        <div class="col-md-3">
                            <% if(profile.getAvatar() != null)
                                { System.out.println("This means avatar is not null");%>
                                <ul>
                                    <li id="avatar"><a href="/Instagrim/Image/<%=profile.getAvatar().getSUUID()%>"><img id="avatarImg" class="img-circle" src="/Instagrim/Thumb/<%=profile.getAvatar().getSUUID()%> "></a><br/><a id="uploadText" href="/Instagrim/upload.jsp" onclick="sessionUploadSet()">Change Avatar</a></li><br/>
                            <% }else{ 
                            %>
                                <ul>
                                    <li id="avatar"><img id="avatarImg" class="img-circle" src="/Instagrim/images/Vendetta.jpg"><br/><a id="uploadText" href="/Instagrim/upload.jsp" onclick="sessionUploadSet()">Change Avatar</a></li>
                                    
                            <%}%>
                            
                            <p><%=profile.getFirstName() + " " + profile.getLastName()%></p>
                            <p><%=lg.getUsername()%></p>
                            <p><%=profile.getEmail()%></p>
                            <p><%=profile.getAddress()%></p>
                                </ul>
                        </div>
                                <div class="col-md-3">
                                    <a href="/Instagrim/Update/<%=lg.getUsername()%>">update profile</a>
                                </div>
                    </div>
                    <div class="col-md-3"></div>
               </div>
               </div>
    </body>
</html>
