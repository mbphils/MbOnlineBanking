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
        </script>    
        <main role="main">
            
            <div class="container">
                <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                    <div class="btn-group" role="group">
                        <g:link class="btn btn-light" action="userClientPage" controller="webPortalManagement" id="${params.id}" class="dropdown-item" >Home</g:link>
                    </div>
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
                    
                </div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                      <li class="breadcrumb-item"><a href="${createLink(uri: '/webPortalManagement/userClientPage')}">Home</a></li>
                      <li class="breadcrumb-item active" aria-current="page">Link Accounts</li>
                    </ol>
                </nav>
                <h3 class="pb-2 mb-4 border-bottom text-title1 border-info">
                    Linked Accounts
                </h3>
                <table class="table table-borderless">
                  <tbody>
                    <tr>
                        <td class="font-weight-bold"><h5>Customer Name <br> <p class="text-success"> ${clientdisplayName}</p></h5>
                        <td class="font-weight-bold"><h5>Customer ID <br> <p class="text-danger"> ${clientCustomerId}</p></h5></td>
                    </tr>
                  </tbody>
                </table>
                <div class="table-responsive">    
                    <table class="table table-striped table-bordered">
                        <thead>
                          <tr>
                            <th scope="col">Account No.</th>
                            <th scope="col">Account Type</th>
                            <th scope="col">Linked Status</th>
                            <th scope="col">Remarks</th>
                            <th scope="col">Actions</th>
                          </tr>
                      </thead>
                      <tbody>
                        <g:each in="${jmdataHandler}" var="accountLinkedd">  
                            <tr>
                                <td>${accountLinkedd.acctNo}</td>
                                <td>${accountLinkedd.acctType}</td>
                                <td>${accountLinkedd.status}</td>
                                <g:if test="${accountLinkedd.remarks == "null"}">
                                    <td></td>
                                </g:if>
                                <g:else>
                                    <td>${accountLinkedd.remarks}</td>
                                </g:else>
                                <g:if test="${accountLinkedd.status == "Active"}">
                                    <td><button class="btn btn-outline-info" onclick="validateToss('${accountLinkedd.id}')">View Transactions</button></td>
                                </g:if>
                                <g:else>
                                    <td><button class="btn btn-outline-danger" disabled="true">Not yet Activated</button></td>
                                </g:else>    
                           </tr>
                        </g:each>    
                      </tbody>
                    </table>
                </div>
                <g:form id="myFormXsend" name="myFormXsend" url="[action:'viewAccountTxn',controller:'WebPortalManagement']" method="POST">
                    <g:hiddenField name="ctmitd" id="ctmitd" value="${params.id}" />
                    <g:hiddenField name="lnkitd" id="lnkitd" value="" />
                </g:form>  
            </div>
        </main>
    </body>
</html>