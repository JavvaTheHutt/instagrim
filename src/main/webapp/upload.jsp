<%-- 
    Document   : upload
    Created on : Sep 22, 2014, 6:31:50 PM
    Author     : Administrator
--%>

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
        <title>InstaGeezAnA</title>
    </head>
    <body>
        <h1>InstaGeezAnA ! </h1>
        <h2>Your world in Black and White</h2>
        <nav>
            <ul>
                <li class="nav"><a href="/InstaGeezAnA/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
 
        <article>
            <h3>File Upload</h3>
            <form method="POST" enctype="multipart/form-data" action="Image">
                File to upload: <input type="file" name="upfile"><br/>

                <br/>
                <input class="hidden" type="text" name="cameFrom" value="aUpload">
                <input type="submit" value="Press"> to upload the file!
                
            </form>

        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/InstaGeezAnA">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
