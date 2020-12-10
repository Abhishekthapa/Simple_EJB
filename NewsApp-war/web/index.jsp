<%-- 
    Document   : index
    Created on : Dec 7, 2009, 6:49:31 PM
    Author     : nb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
        <script>
        $(document).ready(function(){
             
                 $.get("ListNews",function(data){
                  $("#javaquery").html(data);
                 
             });
         });
    </script>
       
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Normal Blog Post</h1>    
        <br />
         <div id="javaquery"><b>Details:</b></div>
    </body>
</html>
