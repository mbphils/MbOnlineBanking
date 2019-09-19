<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sample title</title>
    </head>
    <body>
        <script>
            function subb(){
                document.getElementById("myForm").submit();
            }
        </script>    
        <g:form name="myForm" id="myForm" url="[action:'multisysTester',controller:'webPortalManagement']" method="POST">
            reference no: <g:textField name="referenceNo" id="referenceNo" value="" />
        </g:form>
        <button onclick="subb();">Submit</button>
    </body>
</html>
