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
    <asset:stylesheet src="css/datatables.min.css"/>
    <asset:stylesheet src="css/sweetalert.css"/>
    <style>
    html {
        font-size: 14px;
    }
    @media (min-width: 768px) {
      html {
        font-size: 16px;
      }
    }

    .container {
      max-width: 960px;
    }

    .pricing-header {
      max-width: 700px;
    }

    .card-deck .card {
      min-width: 220px;
    }
    </style>
  </head>
   <body>
    <header>  
        <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
            <h5 class="my-0 mr-md-auto font-weight-normal"><img src="${resource(dir: "images", file: "mbphil.png")}" alt="First slide" > MBPhil Online Banking</h5>
            
            <nav class="my-2 my-md-0 mr-md-3">
                <button id="date_time" class="btn btn-outline-success"></button>
                <a class="btn btn-sm btn-outline-success" data-toggle="tooltip" title="Account Settings" href="${createLink(action: '')}"><span> <i class="fa fa-cog"></i></span></a>
                <a class="btn btn-sm btn-outline-danger" data-toggle="tooltip" title="Logout" href="${createLink(action: 'logoutPage')}"><i class="fa fa-power-off"></i></a>
            </nav>
        </div>
    </header>
    <g:layoutBody/>
    <footer class="pt-4 my-md-5 pt-md-5 border-top">
    <div class="row">
      <div class="col-12 col-md">
        <small class="d-block mb-3 text-muted text-center">&copy; MB Philippines Inc. 2019-2020 <br> Version 1.0</small>
      </div>
  </footer>
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
    
        
    <script>
        $( document ).ready(function() {
            date_time('date_time');
            callLogNotice();
        });
        var systemDownForMaintenance = '${WebConfig.findByParamCode("GEN.1002").paramValue}';
            if(systemDownForMaintenance.toUpperCase() == "TRUE"){
               console.log("system down");
               window.location.href="${createLink(controller:'WebPortalManagement', action:'rdrLandingPage')}"
            }else{
               window.location.href="${createLink(controller:'WebPortalManagement', action:'login')}"
            }
        function date_time(id){
            date = new Date;
            year = date.getFullYear();
            month = date.getMonth();
            months = new Array('January', 'February', 'March', 'April', 'May', 'June', 'Jully', 'August', 'September', 'October', 'November', 'December');
            d = date.getDate();
            day = date.getDay();
            days = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
            h = date.getHours();
            if(h<10){
                h = "0"+h;
            }
            m = date.getMinutes();
            if(m<10){
                m = "0"+m;
            }
            s = date.getSeconds();
            if(s<10){
                s = "0"+s;
            }
            result = ''+days[day]+' '+months[month]+' '+d+' '+year+' '+h+':'+m+':'+s;
            document.getElementById(id).innerHTML = result;
            setTimeout('date_time("'+id+'");','1000');
            return true;
        }
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