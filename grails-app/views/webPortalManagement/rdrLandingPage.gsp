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
    <asset:stylesheet src="css/cover.css"/>
    <asset:stylesheet src="font-awesome/css/font-awesome.min.css"/>
    <asset:stylesheet src="css/animate.css"/>
    
  </head>
  
    <body>
        <div class="cover-container d-flex h-100 p-3 mx-auto flex-column">
            <header class="masthead mb-auto">
<!--              <div class="inner">
                <h3 class="masthead-brand">MBPhils</h3>
                <nav class="nav nav-masthead justify-content-center">
                  <a class="nav-link active" href="#">Home</a>
                  <a class="nav-link" href="#">Features</a>
                  <a class="nav-link" href="#">Contact</a>
                </nav>
              </div>-->
            </header>
            <i class="text-center fa fa-lock fa-5x text-danger animated bounceInDown"></i>
            <div id="alert" class="alert alert-warning alert-dismissible fade show" role="alert" >
              <h4 class="alert-heading">System Under Maintenance</h4>
              <p class="mb-0">Sorry for the inconvenience. We will respond as soon as possible</p>
            </div>


            <main role="main" class="inner cover text-center" >
              <h1 class="cover-heading">Page Not Available</h1>
              <p class="lead">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco </p>
            </main>

            <footer class="mastfoot mt-auto">
<!--              <div class="inner">
                <p>Cover template for <a href="https://getbootstrap.com/">Bootstrap</a>, by <a href="https://twitter.com/mdo">@mdo</a>.</p>
              </div>-->
            </footer>
        </div>
        <script>
            var systemDownForMaintenance = '${WebConfig.findByParamCode("GEN.1002").paramValue}';
            if(systemDownForMaintenance.toUpperCase() == "FALSE"){
               console.log("system down");
               window.location.href="${createLink(controller:'WebPortalManagement', action:'login')}"
            }
        </script>    
    </body>
</html>