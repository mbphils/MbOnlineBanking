<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta charset="UTF-8" />
        <title>[Online Banking]</title>
        <meta name="layout" content="submain">
    </head>
    <asset:javascript src="js/jquery-3.3.1.js"/>

    
    <body>
    <script>

        // Global Variables
        var verificationXCode = "";
        var isUsernameAlreadyExist = "false";
        var isCustomerIdAlreadyExist = "false";
        //=============================================
        
        AppSweetTitle = "Web Banking";
        function msgAlertSweet(AppSweetTitle,description,alertType){
            Swal.fire(AppTitle,description,alertType);
        }
        function validateGeneratedCode(){
        
            var obj = { 
                address: $('#emailAddress').val(),
                reqAction: 'registration'
            }; 
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "${createLink(controller:'WebPortalManagement', action:'sendEmail')}",
                data: JSON.stringify(obj),

                success: function(data){
              
                    obj = JSON.parse(JSON.stringify(data[0]));
                    var codeVerify = obj.responsetexx.toString();
                    console.log("codeVerify: "+codeVerify);
                    verificationXCode = codeVerify
                },
                error: function(data){

                },

            });
            $('#verificationModal').modal('toggle');
        }
        function xtoggelModal(){
            console.log("MMMMMMMMMMMMMMMMMMMMM");
            $('#verificationModal').modal('toggle');
        }
        function validateGeneratedResendCode(){
            var obj = { 
                address: $('#emailAddress').val(),
                reqAction: 'registration'
            }; 
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "${createLink(controller:'WebPortalManagement', action:'sendEmail')}",
                data: JSON.stringify(obj),

                success: function(data){
              
                    obj = JSON.parse(JSON.stringify(data[0]));
                    var codeVerify = obj.responsetexx.toString();
                    console.log("codeVerify: "+codeVerify);
                    verificationXCode = codeVerify
                },
                error: function(data){

                },

            });
            
        }
        function validateCodeThenSubmit(){
            var codeFrmUser = $('#txtverifyCode').val();
            var mainCode = verificationXCode
            
            if(codeFrmUser === mainCode){
                console.log("success");
                var obj = { 
                    customerID: $('#customerId').val(),
                    firstName: $('#firstName').val(),
                    middleName: $('#middleName').val(),
                    lastName: $('#lastName').val(),
                    mobile: $('#mobile').val(),
                    address: $('#address').val(),
                    emailAddress: $('#emailAddress').val(),
                    username: $('#username').val(),
                    txtpassword: $('#txtpassword').val(),

                }; 
                console.log(JSON.stringify(obj));
                console.log("Object Loaded iwth data...");
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "${createLink(controller:'WebPortalManagement', action:'submitUserRegistration')}",
                    data: JSON.stringify(obj),

                    success: function(data){

                        obj = JSON.parse(JSON.stringify(data[0]));
                        var xmxmx = obj.responsetexx.toString();
                        if(xmxmx == "success"){
                            alertify.alert(AppTitle,"Registration Process Done! Please Wait for the bank feedback regarding your online registration activation process Thank you for choosing us!", function(){
                                window.location.href="${createLink(controller:'WebPortalManagement', action:'login')}"
                            });
                            
                        }else{

                        }
                    },
                    error: function(data){

                    },

                });
            }else{
                alertify.alert(AppTitle,"Invalid Verification Code", function(){});
            }
        }
        
        function validateFields(){
            //firstName/middleName/lastName/mobile/emailAddress/username/txtpassword/txtretype
            //var catchaResult = validateCaptcha();
            //console.log("catchaResult: "+catchaResult);
            /*
            if($('#firstName').val() == "" || $('#firstName').val() == null){
                msgAlertSweet(AppTitle,"Sorry, Your First Name is required","error");
                
            }else if($('#lastName').val() == "" || $('#lastName').val() == null){
                msgAlertSweet(AppTitle,"Sorry, Your Last Name is required","error");
                
            }else if($('#customerId').val() == "" || $('#customerId').val() == null){
                msgAlertSweet(AppTitle,"Sorry, Your Customer ID is required","error");
                
            }else if($('#address').val() == "" || $('#address').val() == null){
                msgAlertSweet(AppTitle,"Sorry, Your Address is required","error");
                
            }else if($('#mobile').val() == "" || $('#mobile').val() == null){
                msgAlertSweet(AppTitle,"Sorry, Your Mobile Number is required","error");
                
            }else if($('#emailAddress').val() == "" || $('#emailAddress').val() == null){
                msgAlertSweet(AppTitle,"Sorry, Your Email Address is required","error");
                
            }else if($('#username').val() == "" || $('#username').val() == null){
                msgAlertSweet(AppTitle,"Sorry, Your Username is required","error");
                
            }else if($('#txtpassword').val() == "" || $('#txtpassword').val() == null){
                msgAlertSweet(AppTitle,"Sorry, Your Password is required","error");
                
            }else{
                if(isNaN($('#mobile').val())){
                    // invalid input for mobile number
                    msgAlertSweet(AppTitle,"Sorry, Invalid Mobile Number","error");
                    
                }else if(isCustomerIdAlreadyExist == "true"){
                    msgAlertSweet(AppTitle,"Sorry, Customer ID Already Used","error");
                    
                }else if(isUsernameAlreadyExist == "true"){
                    
                    msgAlertSweet(AppTitle,"Sorry, Username Already Exists Please try another one","error");
                    
                }else if($('#txtpassword').val() != $('#txtretype').val()){
                   
                    msgAlertSweet(AppTitle,"Sorry, Password and Retype password Mismatch","error");
                    
                }else{
                    validateGeneratedCode();
                } 
               
            }*/
             validateGeneratedCode();
            
        }
        //============= WEB CAPTCHA BY JM MARQUEZ ===========
        var code;
        function createCaptcha() {
            //clear the contents of captcha div first 
            document.getElementById('captcha').innerHTML = "";
            var charsArray ="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@!#$%^&*";
            var lengthOtp = 6;
            var captcha = [];
            for (var i = 0; i < lengthOtp; i++) {
              //below code will not allow Repetition of Characters
              var index = Math.floor(Math.random() * charsArray.length + 1); //get the next character from the array
              if (captcha.indexOf(charsArray[index]) == -1)
                captcha.push(charsArray[index]);
              else i--;
            }
            var canv = document.createElement("canvas");
            canv.id = "captcha";
            canv.width = 100;
            canv.height = 50;
            var ctx = canv.getContext("2d");
            ctx.font = "25px Georgia";
            ctx.strokeText(captcha.join(""), 0, 30);
            //storing captcha so that can validate you can save it somewhere else according to your specific requirements
            code = captcha.join("");
            document.getElementById("captcha").appendChild(canv); // adds the canvas to the body element
        }
        function validateCaptcha() {
            //event.preventDefault();
            //debugger
            if (document.getElementById("cpatchaTextBox").value == code) {
              return true;    
            }else{
              alert("Invalid Captcha. Try Again");
              createCaptcha();
              $('#cpatchaTextBox').val('');
              return false;
            }
        }

        //============ END OF CAPTCHA =================
        
        //============ VALIDATE EXISTING USERNAME ===========
        
        function validateExistingUsername(username){
            isUsernameAlreadyExist = "false";
            console.log("username: "+username);
            var obj = { 
                username: $('#username').val(),
            }; 
            console.log(JSON.stringify(obj));
            console.log("Object Loaded iwth data...");
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "${createLink(controller:'WebPortalManagement', action:'validateExistingUsername')}",
                data: JSON.stringify(obj),

                success: function(data){
              
                    obj = JSON.parse(JSON.stringify(data[0]));
                    var xmxmx = obj.responsetexx.toString();
                    console.log("xmxmx: "+xmxmx);
                    if(xmxmx == "success"){
                        var notifier = document.getElementById("usernamenotiff");
                        isUsernameAlreadyExist = "true"
                        notifier.innerHTML = "Username Already Exists!";
                         
                    }else{
                        isUsernameAlreadyExist = "false";
                        var notifier = document.getElementById("usernamenotiff");
                        notifier.innerHTML = "";
                    }
                },
                error: function(data){

                },
            }); 
        }
        function validateCustomerId(){
            console.log("============== validate customer id ===========");
            isCustomerIdAlreadyExist = "false";
            
            var obj = { 
                customerid: $('#customerId').val(),
            }; 
            console.log(JSON.stringify(obj));
            console.log("Object Loaded iwth data...");
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "${createLink(controller:'WebPortalManagement', action:'validateExistingCustomerId')}",
                data: JSON.stringify(obj),

                success: function(data){
              
                    obj = JSON.parse(JSON.stringify(data[0]));
                    var xmxmx = obj.responsetexx.toString();
                    console.log("xmxmx: "+xmxmx);
                    if(xmxmx == "success"){
                        var notifier = document.getElementById("customeridnotiff");
                        isCustomerIdAlreadyExist = "true"
                        notifier.innerHTML = "Customer ID Already Used!";
                    }else{
                        isCustomerIdAlreadyExist = "false";
                        var notifier = document.getElementById("customeridnotiff");
                        notifier.innerHTML = "";
                    }
                },
                error: function(data){

                },
            }); 
        }
        
        //===================================================
        function validateEmail(email) {
            var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(email);
        }

        function validateEmailAddress() {
            var $result = $("#emailAddressNotif");
            var email = $("#emailAddress").val();
            $result.text("");
            
            if (validateEmail(email)) {
              $result.text('');
              
            } else {
              $result.text(email + " is not valid ");
               $result.css("color", "#99ff99");
            }
            if(email == ""){
                $result.text("");
            }
            return false;
        }
    </script>    
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-7 mx-auto" >
                <div class="card card-body shadow p-3 mb-5 rounded animated fadeInUpBig" style="background-color: rgba(0, 0, 0, 0.4);">
                    <h3 class="text-center mb-4 text-light" >Online Banking Registration</h3>
                    <fieldset>
                        <div class="inputs">
                            <div class="card shadow p-3 mb-5 rounded w-150" style="background-color: rgba(0, 0, 0, 0.4);">
                                <div class="card-body">
                                  <h5 class="card-title text-light">Customer Information</h5>
                                   <div class="row">
                                        <div class="col-sm-4">
                                            <div class="form-group has-error text-light">
                                                <label><i class="fa fa-user "></i> First Name</label>
                                                <g:textField name="firstName" id="firstName" value="" tabindex="1" class="form-control input-lg" style="text-transform: capitalize;" />
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group has-error text-light">
                                                <label><i class="fa fa-user "></i> Middle Name</label>
                                                <g:textField name="middleName" id="middleName" value="" tabindex="1" class="form-control input-lg" style="text-transform: capitalize;"/>
                                            </div>
                                        </div>  

                                        <div class="col-sm-4">
                                            <div class="form-group has-error text-light">
                                                <label><i class="fa fa-user"></i> Last Name</label>
                                                <g:textField name="lastName" id="lastName" value="" tabindex="3" class="form-control input-lg" style="text-transform: capitalize;"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card shadow p-3 mb-5 rounded w-150 " style="background-color: rgba(0, 0, 0, 0.4);">
                                <div class="card-body">
                                  <h5 class="card-title text-light">ID and Address</h5>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group has-error text-light">
                                                <label><i class="fa fa-id-card"></i> Customer ID</label>
                                                
                                                <g:textField name="customerId" id="customerId" value="" onblur="validateCustomerId();" tabindex="4"  class="form-control input-lg" />
                                                <p id="customeridnotiff" style="color: #99ff99;font-style: italic;font-size: 75%;"></p>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="form-group has-error text-light">
                                                <label><i class="fa fa-map-marker"></i> Address</label>
                                                <g:textField name="address" id="address" value="" tabindex="5" class="form-control input-lg" style="text-transform: capitalize;"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card shadow p-3 mb-5 rounded w-150" style="background-color: rgba(0, 0, 0, 0.4);">
                                <div class="card-body">
                                  <h5 class="card-title text-light">Contact Information</h5>
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <div class="form-group has-error text-light">
                                                <label><i class="fa fa-phone-square"></i> Phone Number</label>
                                                <g:textField name="mobile" id="mobile" value="" tabindex="6" type="number" class="form-control input-lg" />
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group has-error text-light">
                                                <label><i class="fa fa-envelope"></i> Email</label>
                                                <g:textField name="emailAddress" id="emailAddress" value="" tabindex="7" onblur="validateEmailAddress();" class="form-control input-lg" />
                                                <p id="emailAddressNotif" style="color: #99ff99;font-style: italic;font-size: 75%;"></p>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group has-error text-light">
                                                <label><i class="fa fa-calendar"></i> Birthdate</label>
                                                <input name="birthday" type="date" tabindex=8 class="form-control input-lg">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card shadow p-3 mb-5 rounded w-150" style="background-color: rgba(0, 0, 0, 0.4);">
                                <div class="card-body">
                                  <h5 class="card-title text-light">Account Information</h5>
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <div class="form-group has-error text-light">
                                                <label><i class="fa fa-user"></i> User Name</label>
                                                <g:textField name="username" id="username" value="" tabindex="9" class="form-control input-lg" onblur="validateExistingUsername(this.value);"/>
                                                <p id="usernamenotiff" style="color: #99ff99;font-style: italic;font-size: 75%;"></p>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group has-success text-light">
                                                <label><i class="fa fa-lock"></i> Password</label>
                                                <g:passwordField name="txtpassword" id="txtpassword" value="" tabindex="10"class="form-control input-lg"/> </br>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group has-success text-light">
                                                <label><i class="fa fa-lock"></i> Confirm Password</label>
                                                <g:passwordField name="txtretype" id="txtretype" value="" tabindex="11" class="form-control input-lg"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                             </div>
                            <br>
                            

                            <%--<input class="btn btn-lg btn-primary btn-block" value="Register" type="submit"> --%>
                            <button class="btn btn-lg btn-warning btn-block" onclick="validateFields();">Register</button>
                             <button class="btn btn-lg btn-warning btn-block" onclick="xtoggelModal();">Toggle</button>
                            <%--<button class="btn btn-lg btn-success btn-block" onclick="validateFields();">Login</button> --%>
                            
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
    </div>
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
    <!-- container -->
  </body>
</html>








 





