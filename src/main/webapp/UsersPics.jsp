<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>

<%@page import="uk.ac.dundee.computing.aec.InstaGeezAnA.lib.Convertors"%>
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
        <%  LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
            boolean owner = (boolean) session.getAttribute("Owner");
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
                        <li class="active"><a href="/InstaGeezAnA/Images/<%=lg.getUsername()%>">Images</a></li>
                        <li><a href="/InstaGeezAnA/Profile/<%=lg.getUsername()%>">Profile</a></li>
                      </ul>
                      <ul id="rightnav" class="nav navbar-nav navbar-right">
                        <li><a href="/InstaGeezAnA/Logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                      </ul>
              </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
          </div>
 
        <article id="gallery" class="gallery">
        <div id="ImagesConatainer" class="container">
            <h3 class="h3">Pictures</h3>
        <%
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
            java.util.LinkedList<Comment> lsComments = (java.util.LinkedList<Comment>) request.getAttribute("Comments");
            if (lsPics == null) {
        %>
        <p>No Pictures found</p>
        <%
        } else {
            Iterator<Pic> iterator;
            iterator = lsPics.iterator();
            while (iterator.hasNext()) {
                Pic p = (Pic) iterator.next();

        %>
        <a href="/InstaGeezAnA/Image/<%=p.getSUUID()%>" ><img id="userImage" src="/InstaGeezAnA/Image/<%=p.getSUUID()%>"></a>
        <%
        if(owner)
        {%>
        <form class="form-horizontal" method="POST"  role="form">
                    <button id="deleteButton"  type="submit" class="btn btn-primary">Delete Image</button>
                    <input class="hidden" type="text" name="picid" value="<%=p.getSUUID()%>">
                    <input class="hidden" type="text" name="cameFrom" value="DeletePhoto">
        </form>
                    <% session.setAttribute("Owner", false);
        } if (lsComments == null) {}else{
            Iterator<Comment> iterator2;
            iterator2 = lsComments.iterator();
            while (iterator2.hasNext()) {
                Comment c = (Comment) iterator2.next();
                if(c.getPicid().toString().equals(p.getSUUID()))
                {
        %>
            <div id="commentDisplay"class="container">
                <div class="row">
                    <div class="col-md-4 col-md-offset-1">
                        <ul>
                            <li id="commentUsername"><%=c.getUsername()%></li>
                            <li id="CommentComment"><%=c.getComment()%></li>
                        </ul>
                    </div>
                </div>
            </div>
            
        <%}}}%>
        <form class="form-horizontal" method="POST"  role="form">
            <div id="commentInput" class="form-group">
                    <textarea id="commentBox" class="form-control" type="text" name="comment" placeholder="Comment..."></textarea>
                    <button id="commentButton"  type="submit" class="btn btn-primary">comment</button>
            </div>
            <input class="hidden" type="text" name="picid" value="<%=p.getSUUID()%>">
            <input class="hidden" type="text" name="username" value="<%=lg.getUsername()%>">
            <input class="hidden" type="text" name="cameFrom" value="aComment">
        </form>
        <br/><%

            }
            }
        %>
        </div>
        </article>
    </body>
</html>
