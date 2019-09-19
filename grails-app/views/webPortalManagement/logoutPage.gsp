<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>[Online Banking]</title>
    <meta name="layout" content="homeLayout">
    
  </head>
  
    <body>
        <div class="container">
            <g:javascript>
                /*jmready();
                function jmready(){
                    console.log("im ready");
                    if(document.referrer != '${createLink(controller:'WebPortalManagement', action:'logoutPage')}'){ 
                        history.pushState(null, null, 'login');
                        window.addEventListener('popstate', function () {
                            history.pushState(null, null, 'login');
                        });
                    }
                }*/
                
            </g:javascript>   
                <div class="jumbotron text-white "  style="box-shadow: 0 4px 20px  0 rgba(0, 0, 0, 0.2), 0 8px 10px 0 rgba(0, 0, 0, 0.19);background-image: linear-gradient(to right, #222, #666);">
                    <div class="container">
                        <h1 class="display-4 animated fadeInDown" ><span class=" fa fa-check "></span>Logged out Successfully</h1>
                        <p class="lead animated fadeInLeftBig">Goodbye and see you again.</p>
                        <g:link class="btn btn-outline-secondary text-white btn-lg animated fadeInUpBig" controller="webPortalManagement" action="login "><span class="fa fa-lock"></span> Login</g:link>
                    </div>
                </div>
                <div class="card ">
                  <div class="card-header font-weight-bold" style="background-image: linear-gradient(to right, skyblue, navy); color:navy;">Concerns / Suggestion</div>
                    <div class="card-body">
                      <h5 class="card-title">Thank you for Logging in</h5>
                      <p class="card-text">We'd love to hear from you. Contact us at sample@gmail.com</p>
                    </div>
                </div>
        </div>
    </body>
</html>