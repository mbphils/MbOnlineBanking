<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>[Online Banking]</title>
    <meta name="layout" content="homeLayout">
  </head>
  
    <body>
        <script>
            function validateToss(lnk){
                console.log("lnk: "+lnk);
                $('#lnkitd').val(lnk);
                $('#myFormXsend').submit();
            }
            function Comma(Num) { //function to add commas to textboxes
                Num += '';
                Num = Num.replace(',', ''); Num = Num.replace(',', ''); Num = Num.replace(',', '');
                Num = Num.replace(',', ''); Num = Num.replace(',', ''); Num = Num.replace(',', '');
                x = Num.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1))
                    x1 = x1.replace(rgx, '$1' + ',' + '$2');
                return x1 + x2;
            }
            function AddComma(){
                
                $('#txnAmount').val(Comma($('#txnAmount').val()));
            }
            function validateFields(){
                
                if($('#fundingAcct').val() == "" || $('#fundingAcct').val() == null){
                    var message = "Sorry, Please Select funding account";
                    errorSwal(message);
                }else if ($('#desAcctNumber').val() == "" || $('#desAcctNumber').val() == null){
                    var message = "Sorry, Please Input valid Destination account number";
                    errorSwal(message);
                }else if ($('#txnAmount').val() == "" || $('#txnAmount').val() == null || isNaN($('#txnAmount').val().replace(',', ''))){
                    var message = "Sorry, Please Input Valid Transfer Amount";
                    errorSwal(message);
                }else if (parseFloat($('#txnAmount').val().replace(',', '')) <= 0 ){
                    var message = "Sorry, Transfer amount cannot be less than or equal to zero";
                    errorSwal(message);
                }else{
                    var obj = { 
                        funlnk: $('#fundingAcct').val(),
                        deacnum: $('#desAcctNumber').val(),
                        trnsframt: $('#txnAmount').val().replace(',', '')
                    }; 

                    $.ajax({
                        type: "POST",
                        contentType: "application/json",
                        url: "${createLink(controller:'WebPortalManagement', action:'validateTransferFunds')}",
                        data: JSON.stringify(obj),

                        success: function(data){

                            obj = JSON.parse(JSON.stringify(data[0]));
                            var message = obj.responsetexx.toString();
                            var xmxmx = obj.reponseCode.toString();

                            if(xmxmx == "success"){
                                
                                validateGeneratedCode();

                            }else{
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
                reqAction: 'transferFunds'
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
            $('#valdidx').val('validated');
            $('#verificationModal').modal('toggle');
            
        }
        function validateGeneratedResendCode(){
            var obj = { 
                reqAction: 'transferFunds'
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
                            $('#xtransferFunds').submit();
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
        <main role="main">
            
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
                      <li class="breadcrumb-item"><a href="${createLink(uri: '/webPortalManagement/home')}">Home</a></li>
                      <li class="breadcrumb-item active" aria-current="page">Transfer Funds</li>
                    </ol>
                </nav>
                <h1 class="display-4">Transfer Funds</h1>
                    <g:form id="xtransferFunds" url="[action:'saveTransferFundsTxn',controller:'WebPortalManagement']" method="POST">
                    <div class="form-group">
                        <label><strong>Funding Deposit Account</strong></label>
                        <g:select id="fundingAcct" name="fundingAcct.id" from="${jmdataHandler}" optionKey="id" optionValue="description" required="" value=""  noSelection="['':'Choose funding account']" class="many-to-one form-control"/>
                        <g:hiddenField name="valdidx" id="valdidx" value="${params.id}" />   
                    </div>    
                    <div class="form-group">
                        <label><strong>Destination Deposit Account Number</strong></label>
                        <g:textField id="desAcctNumber" name="desAcctNumber" class="form-control" placeholder="XXX-XXX-XXXXX-X"  />

                    </div>
                    <div class="form-group">
                        <label><strong>Transfer Amount</strong></label>
                        <g:textField id="txnAmount" name="txnAmount" class="form-control" onkeyup="AddComma();" placeholder="Account Number"  />

                    </div>
                    </g:form>
                        <button class="btn btn-primary" id="validation7" onclick="validateFields();">Submit Transfer Funds</button>

                    <br>
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
            </div>
        </main>
    </body>
</html>