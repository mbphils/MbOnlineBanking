<!DOCTYPE html>
<%@ page import="mbonlinebanking.WebConfig" %>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>[Online Banking]</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <asset:stylesheet src="css/registrationCss.css"/>
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
        <center>
        <div class="header">
            
        </div>
        </center>
    </header>
    <div class="main-body">
         <g:layoutBody />
    </div>
    <!-- Footer -->
<!--    <footer>
      <div class="container text-center">
        <p>Copyright &copy; Your Website 2018</p>
      </div>
    </footer>-->
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
<!--    <asset:javascript src="js/jquery-3.3.1.js"/>-->
   <script>
       var systemDownForMaintenance = '${WebConfig.findByParamCode("GEN.1002").paramValue}';
            if(systemDownForMaintenance.toUpperCase() == "TRUE"){
               console.log("system down");
               window.location.href="${createLink(controller:'WebPortalManagement', action:'rdrLandingPage')}"
            }
        // ready function
        $( document ).ready(function() {
            
            callLogNotice();
        });
        
        //============================== LOG NOTICE =======================================
        function callLogNotice(){
            console.log('%cSTOP! ', 'color: #FF5733;font-size:50px');
            console.log('%cThis is a browser feature intended for Express O Online Banking Developers! ', 'color: #0A954F;font-size:30px');
            console.log('%cyou are not allowed here ', 'color: #FF5733;font-size:25px');
            console.log('%cIf someone told you to copy-paste something here to enable a feature or "hack" someone`s account you will be punished by the law', 'color: #666160;font-size:25px');

        }
        
        // ============================= ALERT MSG BOX CODES ===============================
        AppTitle = "Web Banking";
        alertify.defaults.theme.ok = "btn btn-primary";
        alertify.defaults.theme.cancel = "btn btn-danger";
        alertify.defaults.theme.input = "form-control";
        
        function getImg(x){
            switch(x){
                case "success" :
                    return "/MbOnlineBanking/assets/alert/check.jpg";break;
                case "warning" :
                    return "/MbOnlineBanking/assets/alert/warning.jpg";break;
                case "error" :
                    return "/MbOnlineBanking/assets/alert/error.jpg";break;
                case "info" :
                    return "/MbOnlineBanking/assets/alert/info.jpg";break;
                case "alert" :
                    return "/MbOnlineBanking/assets/alert/siren.jpg";break;
            }
        }
        var notify = {
            init : function(){
                alertify.set('notifier','position', 'top-right');
            },

            message : function(s) {
                 console.log("whooooo");
                if(s.indexOf("|") > -1){
                    var msg = s.split("|"), whatkind = msg[1];
                    if(msg.length > 2){
                        whatkind = msg[2];
                        console.log("whatkind: "+whatkind);
                    } 

                    if(whatkind.indexOf("warn") == 0){
                        whatkind = "warning";
                    }
                    this.init();
                    if(whatkind == 'alert') {
                        if(msg.length > 2){ 
                            console.log("hello boy");
                            console.log("msg1 : "+msg[1]);
                            var newmsg = "<div class='col-md-2'><img src='"+getImg(msg[1])+"' height=64 width=64></div>";
                            newmsg += "<div class='col-md-10'><h5>"+msg[0]+"</h5></div>";
                            alertify.alert(AppTitle,newmsg,function(){});
                        } else {
                            alertify.alert(AppTitle,msg[0],function(){});
                        }
                    } else {
                        alertify.notify(msg[0],whatkind);
                    }
                } else {
                    this.info(s);
                }
                //console.log(s);
            },
            success : function(s) {
                this.init();
                alertify.success(s);
            },
            error : function(s) {
                this.init();
                alertify.error(s);
            },
            info : function(s) {
                this.init();
                alertify.notify(s);
            },
            warn : function(s) {
                this.init();
                alertify.warning(s);
            },
            warning : function(s) {
                this.init();
                alertify.warning(s);
            },
            alert : function(s) {
                this.init();
                alertify.alert(AppTitle,s);
            },
            confirm : function(s) {
               this.init();
               var ret = alertify.confirm(AppTitle,s);
               return ret;
            }
        }
    </script>
  </body>
</html>