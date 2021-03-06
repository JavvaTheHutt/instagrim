<%-- 
    Document   : friendsList
    Created on : 22-Oct-2015, 17:13:45
    Author     : MatthewLang
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.InstaGeezAnA.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
    </head>
    <body>
        <% LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
           session.setAttribute("username", lg.getUsername());
           ProfileBean profile = (ProfileBean) session.getAttribute("ProfileBean");
        %>
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
                        <li><a href="/InstaGeezAnA/Profile/<%=lg.getUsername()%>">Profile</a></li>
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
              </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
          </div>
 
        
            <div class="container">
                <h1 class="h1">Results:</h1>
                    <%
                        java.util.LinkedList<ProfileBean> lsProf = (java.util.LinkedList<ProfileBean>) request.getAttribute("lsProfiles");
                        if (lsProf.isEmpty() || lsProf == null) {
                    %>
                        <p>No Users Found</p>
                    <%
                    } else {
                        Iterator<ProfileBean> iterator;
                        iterator = lsProf.iterator();
                        while (iterator.hasNext()) {
                            ProfileBean p = (ProfileBean) iterator.next();
                        if(p.getUsername()!= lg.getUsername())
                        {
                    %>
                    <% if(p.getAvatar() != null)
                                        {%>
                        <a href="/InstaGeezAnA/Profile/<%=p.getUsername()%>" ><img src="/InstaGeezAnA/Image/<%=p.getAvatar().getSUUID()%>"></a>
                     <% }else{ 
                                    %>
                        <a href="/InstaGeezAnA/Profile/<%=p.getUsername()%>" ><img class="img-responsive" src="/InstaGeezAnA/images/Vendetta.jpg"></a>
                    <%}%>
                        
                        <a href="/InstaGeezAnA/Profile/<%=p.getUsername()%>" ><%=p.getUsername()%></a>
                        <br/>
                    <%
                        }
                        }
                    }
                    %>
            </div>
    </body>
</html>

