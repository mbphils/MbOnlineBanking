<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="mbonlinebanking.WebConfig" %>

<html>
    <head>
        <meta charset="UTF-8" />
        <title>[Online Banking]</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />


        <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
        <asset:stylesheet src="font-awesome/css/font-awesome.min.css"/>
        <asset:stylesheet src="css/grayscale.css"/>
        <asset:stylesheet src="alertify.min.css"/>
        <asset:stylesheet src="css/animate.css"/>
        <asset:stylesheet src="css/sweetalert.css"/>
      </head>
    
    <%--<script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>--%>
    
    <g:javascript> 
       
        
        var loginAttempsCounter = 0;
        function validateFields(){
            
            var obj = { 
                username: $('#username').val(),
                txtpassword: $('#txtpassword').val(),
                
            }; 
            console.log(JSON.stringify(obj));
            console.log("Object Loaded iwth data...");
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "${createLink(controller:'WebPortalManagement', action:'validateLoginCredentials')}",
                data: JSON.stringify(obj),

                success: function(data){
              
                    obj = JSON.parse(JSON.stringify(data[0]));
                    var responsetexx = obj.responsetexx.toString();
                    console.log("responsetexx: "+responsetexx);
                    var reponseResult = obj.reponseResult.toString();
                    console.log("reponseResult: "+reponseResult);
                    if(reponseResult == "invalid"){
                        //for login attemps
                        loginAttempsCounter = loginAttempsCounter + 1;
                        console.log("loginAttempsCounter: "+loginAttempsCounter);
                        console.log('Pumasok sa error');
                        var message="Sorry, Invalid username or password. Please try again."
                        errorSwal(message);
                    }else if(reponseResult == "notActivated"){
                        window.location.href = "${createLink(controller:'WebPortalManagement', action:'rdrValStat')}"
                    }else{
                        var openTunneltoPortal = $('#urlredirectInstance').val();
                        window.location.href=""+openTunneltoPortal+responsetexx;
                       
                    }
                    
                    
                },
                error: function(data){

                },

            }); 
        }
      
    </g:javascript>   
<body>
    
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top shadow-sm p-3 mb-5 bg-white rounded" id="mainNav" >
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#page-top"></a>
      </div>
    </nav>
    <header class="masthead">
        <div class="container">
            <div class="row">
                <div class="col animated bounceInLeft col-xs-12 text-md-left text-center">
                  <h1 class="brand-heading">Welcome</h1>
                  <h5>MBPhil Express-O Online Banking</h5>
                  <p class="intro-text">You can now view your account online </p>
                </div>
                <div class="col ">
                   <div class="col-md-12 animated bounceInRight">
                        <div class="card mb-3 shadow rounded">
                            <div class="card-header font-weight-bold" style="color:#fff;">LOGIN FORM</div>
                            <div class="card-body">
                              <h5 class="card-title"></h5>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="inputGroupPrepend"><i class="fa fa-user"></i></span>
                                            </div>
    <!--                                        <input type="text" class="form-control" id="exampleInputEmail2" placeholder="Username" required>-->
                                             <g:textField name="username" id="username" value="" class="form-control" placeholder="Username"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="inputGroupPrepend"><i class="fa fa-key"></i></span>
                                            </div>
                                           <g:passwordField name="txtpassword" id="txtpassword" value="" class="form-control" placeholder="Password"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <button class="btn btn-outline-success btn-block" onclick="validateFields();">Login </button>
                                    </div>
                                    <g:hiddenField name="urlredirectInstance" id="urlredirectInstance" value="${urlRedirectInstance}" />
                                    <div class="form-group">
                                        <label>Not yet Enrolled?</label>
                                        <g:link action="agreement" controller="webPortalManagement" >Enroll Now</g:link>

                                    </div>
                            </div>
                        </div>
                    </div>
               </div>
            </div>
        </div>
    </header>
    <!-- Footer -->
    
    <!-- Bootstrap core JavaScript -->
    <asset:javascript src="jquery/jquery.min.js"/>
    <asset:javascript src="js/bootstrap.min.js"/>
    <asset:javascript src="js/alertify.min.js"/>
    <asset:javascript src="js/sweetalert.min.js"/>
    <asset:javascript src="js/sweetalert.js"/>
    <asset:javascript src="js/sweetAlertFunctions.js"/>
    <script>
    
    </script>
    </body>
</html>
