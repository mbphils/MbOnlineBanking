<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>[Online Banking]</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
   <style>
        .MBagreement {
            font-family: tahoma;
            font-weight: 30px;
            height: 200px;
            overflow: scroll;
            text-align: justify;
           
        }
        .container{
            margin: auto;
            padding:50px;
        }
    </style>
   <body>
        
        <script>
            
            
            AppTitle = "Online Banking";
            
            function validateAgreement(){
               
                if($("#usercheckbox").is(':checked')){
                    console.log("check box is checked");
                    $('#changeFormtoReg').submit();
                }else{
                    console.log("wlaang kwenta ");
                    Swal.fire(
                        AppTitle,
                        'You must accept the Terms and Conditions for this page',
                        'error'
                    )
                    
                }
            }
            
        </script>    
        <g:form name="changeFormtoReg" id="changeFormtoReg" method="POST" url="[action:'registration',controller:'WebPortalManagement']">
            <g:hiddenField name="isAcceptByUser" id="isAcceptByUser" value="true" />
        </g:form>    
        <div class="container">
            <div class="row">
                <div class="card border-dark mb-3 card-container">
                    <div class="card-header">Terms and Conditions</div>
                    <div class="card-body text-dark">
                        <h5 class="card-title">Electronic Banking Terms and Conditions of Use</h5>
                        
                        <div class="MBagreement">
                            <g:render template="agreement/txtFile"/>
                        </div>
                    </div>
                     <div class="card-footer bg-transparent border-dark">
                        
                        <div class="form-group">
                            <label class="checkbox-inline">
                            <input  type="checkbox" id="usercheckbox" name="checkbox" value=""> I have read, fully understood and agreed with the Terms and Conditions.</label>
                            <g:link class="btn btn-secondary" action="login" controller="admin" >Back</g:link>
                            <%-- <g:link class="btn btn-success" action="registration" controller="webPortalManagement" >Submit</g:link> --%>
                            <button class="btn btn-success" onClick="validateAgreement();">Submit</button>
                        </div>

                    </div>   
                </div>
            </div>
        </div>
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