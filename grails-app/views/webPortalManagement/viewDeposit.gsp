<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>[Online Banking]</title>
    <meta name="layout" content="homeLayout">
  </head>
<body>
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
        <br>
        <h3 class="pb-4 mb-4 border-bottom text-title1 border-info">
             Account Information
        </h3>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="${createLink(uri: '/webPortalManagement/userClientPage')}">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Account Information</li>
            </ol>
        </nav>
        <div class="row">
            <div class="col-sm-6">
                <div class="row no-gutters border rounded border-secondary overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                    <div class="col p-4 d-flex flex-column position-static">
                        <strong class="d-inline-block mb-2 text-primary">Customer Information</strong>
                        <h5 class="mb-0 " >Customer Account No.</h5>
                        <div class="mb-1 text-muted">1-234567-89</div>
                        <h5 class="mb-0 " >Customer name</h5>
                        <div class="mb-1 text-muted">Juan Dela Cruz</div>
                        <h5 class="mb-0 " >Product</h5>
                        <div class="mb-1 text-muted">Regular Savings Deposit</div>
                        <h5 class="mb-0 " >Status</h5>
                        <div class="mb-1 text-muted">Closed</div>
                        
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="row no-gutters border rounded border-secondary overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position">
                    <div class="col p-4 d-flex flex-column position-static">
                        <strong class="d-inline-block mb-2 text-primary">Accounts Balances</strong>
                        <table>
                            <tr>
                                <td><h5 class="mb-0">Current Balance</h5></td>
                                <td><span class="badge badge-warning">9,9999,9999999</span></td>
                            </tr>
                            <tr>
                                <td><h5 class="mb-0">Available Balance</h5></td>
                                <td><span class="badge badge-warning">500</span></td>
                            </tr>
                            <tr>
                                <td><h5 class="mb-0">Hold Balance</h5></td>
                                <td><span class="badge badge-warning">200</span></td>
                            </tr>
                            <tr>
                                <td><h5 class="mb-0">Uncleared Balance</h5></td>
                                <td><span class="badge badge-warning">200</span></td>
                            </tr>
                        </table>
                        <br><br><br><br>
                    </div>
                    <table>
                        <tr>
                            <td>
                                
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <h3 class="pb-4 mb-4 border-bottom text-title1 border-info">
            Deposit Transactions
        </h3>
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                      <th scope="col">Reference</th>
                      <th scope="col">Description</th>
                      <th scope="col">Transaction Date</th>
                      <th scope="col">Debit</th>
                      <th scope="col">Credit</th>
                      <th scope="col">Balance</th>

                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th scope="row">12345</th>
                        <td>Testing</td>
                        <td>2019-08-01</td>
                        <td>1000</td>
                        <td></td>
                        <td>1000</td>

                    </tr>
                    <tr>
                        <th scope="row">67890</th>
                        <td>Testing</td>
                        <td>2019-08-01</td>
                        <td></td>
                        <td>500</td>
                        <td>500</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>