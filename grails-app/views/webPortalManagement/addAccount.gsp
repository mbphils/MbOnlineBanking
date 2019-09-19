
<%@ page import="mbonlinebanking.LovAccountType" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>[Online Banking]</title>
    <meta name="layout" content="homeLayout">
    
  </head>
    
    <body>
        <asset:javascript src="js/jquery-3.3.1.js"/>
        <div class="container">
            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                <div class="btn-group" role="group">
                  <button id="btnGroupDrop1" type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Manage Accounts
                  </button>
                  <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                    <g:link action="addAccount" controller="webPortalManagement" id="${params.id}" class="dropdown-item" >Add/Link Account</g:link>
                    <g:link action="accountOverview" controller="webPortalManagement" id="${params.id}" class="dropdown-item" >View Link Account </g:link>
                  </div>
                </div>
                <div class="btn-group" role="group">
                  <button id="btnGroupDrop1" type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Transactions
                  </button>
                  <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                    <g:if test="${params.id}">
                        <g:link action="transferFunds" controller="webPortalManagement" id="${params.id}" class="dropdown-item" >Transfer Funds</g:link>
                    </g:if>
                    <g:else>
                        <g:link action="transferFunds" controller="webPortalManagement" id="${xParms}" class="dropdown-item" >Transfer Funds</g:link>
                    </g:else>

                    <%--<g:link action="paybills" controller="webPortalManagement" class="dropdown-item" >Bills Payment</g:link>
                    <g:link action="" controller="webPortalManagement" class="dropdown-item" >Loan Payment</g:link>
                    <g:link action="" controller="webPortalManagement" class="dropdown-item" >Request Statement</g:link>
                    <g:link action="" controller="webPortalManagement" class="dropdown-item" >Request Checkbook</g:link> --%>
                  </div>
                </div>
                <div class="btn-group" role="group">
                    <g:link class="btn btn-light" action="home" controller="webPortalManagement" id="${params.id}" class="dropdown-item" >Home</g:link>

                </div>
            </div>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item"><g:link controller="WebPortalManagement" action="userClientPage" id="${params.id}">Home</g:link></li>
                  <li class="breadcrumb-item active" aria-current="page">Add Account</li>
                </ol>
            </nav>
            <h3 class="pb-2 mb-4 border-bottom text-title1 border-info">
                Add Account
            </h3>
            <g:form id="frmLinkacct" url="[action:'getLinkedAccount',controller:'WebPortalManagement']" method="POST">
                <div class="form-group ">
                    <g:hiddenField name="acctId" id="acctId" value="${params.id}"/>
                    <g:hiddenField name="xemail" id="xemail" value="${addAccountMaps.emailAddress}"/>
                   
                    <label for="inputState">Select Account Type</label>
                    <g:select id="accountType" name="accountType.id" from="${LovAccountType.findAllByStatus(true)}" optionKey="id" optionValue="description" required="" value="" noSelection="['':'Choose Account Type']" class="many-to-one form-control"/>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label for="validationCustom03">Account Number</label>
                            <g:textField id="acctNumber" name="acctNumber" class="form-control" placeholder="Account Number"  />
                            <div class="invalid-feedback">
                              Please provide a valid city.
                            </div>
                            <div class="valid-feedback">
                                Looks good!
                            </div>
                        </div>
                    </div>

                </div>
            </g:form>
            <%-- MODAL --%>
            <div class="modal fade" id="verificationModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                          <h4 class="modal-title">ACCOUNT PRE VALIDATION PROCESS</h4>
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <!-- Modal body -->
                        <div class="modal-body">
                            <p>The Your Code Already Sent To Your Email Account (Gmail) Kindly check your account to get your verification code..</p>
                            </br>

                            <div class="col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="control-label">Verification Code<small>(required)</small></label>
                                    <g:textField name="verificationCodes" id="txtverifyCode" value="" class="form-control" />
                                </div>
                            </div>

                            </br>
                        </div>
                        <!-- Modal footer -->
                        <div class="modal-footer">

                          <button type="button" class="btn btn-danger" onclick="validateGeneratedResendCode();">Resend Code</button>
                          <button type="button" class="btn btn-success" onclick="validateCodeThenSubmit();">Submit</button>
                        </div>
                    </div>
                </div>
            </div>                
            <%-- END MODAL --%>   
            <button class="btn btn-primary" type="submit" onclick="validateFields();">Submit form</button>
            </br></br></br>
            
        </div>  
    <script>
	var verificationXCode = "";
        $( document ).ready(function() {
            console.log( "ready!" );
        });
        function validateFields(){
            var xacctType = $('#accountType').val();
            var xacctNumber = $('#acctNumber').val();

            if(xacctType == "" || xacctType==null){
                var message = "Please Select Account Type";
                errorSwal(message);
                
					
            }else if(xacctNumber == "" || xacctNumber==null){
                var message = "Account Number cannot be empty";
                errorSwal(message);
				   
            }else{
                var obj = { 
                    acctNo: xacctNumber,
                    acctType: xacctType,
                }; 
                
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "${createLink(controller:'WebPortalManagement', action:'validateLinkAccount')}",
                    data: JSON.stringify(obj),

                    success: function(data){

                        obj = JSON.parse(JSON.stringify(data[0]));
                        var xmxmx = obj.responsetexx.toString();
                        
                        
                        if(xmxmx == "notfound"){
                            validateGeneratedCode();
                        }else{
                            var message = "Sorry, This Account was already linked Try another account";
                            errorSwal(message);
                        }
                    },
                    error: function(data){
                        
                    },
                }); 
                
            }
        }
        function validateGeneratedCode(){
        
            var obj = { 
                reqAction: 'linkAccount'
            }; 
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "${createLink(controller:'WebPortalManagement', action:'sendEmail')}",
                data: JSON.stringify(obj),

                success: function(data){
              
                    obj = JSON.parse(JSON.stringify(data[0]));
                    var codeVerify = obj.responsetexx.toString();
                    verificationXCode = codeVerify
                },
                error: function(data){

                },

            });
            $('#verificationModal').modal('toggle');
            
        }
        function validateGeneratedResendCode(){
            var obj = { 

                reqAction: 'linkAccount'
            }; 
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "${createLink(controller:'WebPortalManagement', action:'sendEmail')}",
                data: JSON.stringify(obj),

                success: function(data){
                    obj = JSON.parse(JSON.stringify(data[0]));
                    var codeVerify = obj.responsetexx.toString();
                    verificationXCode = codeVerify
                },
                error: function(data){

                },

            });
            
        }
        function validateCodeThenSubmit(){
           
            var userCode = $('#txtverifyCode').val();
            
            if(userCode == verificationXCode){
                
                swal({
                    title: 'Are you sure?',
                    text: "You won't be able to revert this!",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Submit!'       
                }).then((result) => {
                    if (result.value) {
                        swal(
                          'Submitted!',
                          'Your request has been Submitted.',
                          'success', 
                        ).then((result) => {
                            $('#frmLinkacct').submit();
                        });
                    }else{
                        swal(
                          'Cancelled!',
                          'Request has been Cancelled.',
                          'error', 
                        )
                    }
                });
                
            }else{
                var message = "Sorry, Invalid Verification code";
                errorSwal(message);
            }
            
        }
    </script>
    <p>BOOM: ${session.usersession}</p>  
    </body>
</html>