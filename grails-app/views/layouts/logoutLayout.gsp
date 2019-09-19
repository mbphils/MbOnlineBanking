<!DOCTYPE html>
<%@ page import="mbonlinebanking.WebConfig" %>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>[Online Banking]</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
    <asset:stylesheet src="css/alertify.min.css"/>
    <asset:stylesheet src="css/animate.css"/>
    <asset:stylesheet src="font-awesome/css/font-awesome.min.css"/>
    <asset:stylesheet src="css/sticky-footer.css"/>
    <asset:stylesheet src="css/datatables.min.css"/>
    <asset:stylesheet src="css/sweetalert.css"/>
  </head>
   <body>
    <header>  
        <div class="container">
            <!-- Navigation -->
            <nav class="navbar navbar-light bg-light shadow-sm  rounded"  >
                  <div class="col">
                      <a class="navbar-brand"href="#">
                        <h5 class="display-5" >
                        <img src="${resource(dir: "images", file: "mbphil.png")}" alt="First slide" > MBPhil Express-O Online Banking</h5>
                      </a>
                  </div>
            </nav>
            <br>
                
    </header>
    <div class="main-body">
         <g:layoutBody />
    </div>
    
    <!-- Bootstrap core JavaScript -->
         
    <asset:javascript src="jquery/jquery.min.js"/>
    <asset:javascript src="js/bootstrap.bundle.min.js"/>
    <asset:javascript src="js/popper.min.js"/>
    <asset:javascript src="js/bootstrap.min.js"/>
    <asset:javascript src="js/alertify.min.js"/>
    <asset:javascript src="js/moment-locales.js"/>
    <asset:javascript src="js/datatables.min.js"/>
    <asset:javascript src="js/sweetalert.min.js"/>
    <asset:javascript src="js/sweetalert.js"/>
    <asset:javascript src="js/sweetAlertFunctions.js"/>
    
        
    
  </body>
</html>