<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>[Online Banking]</title>
    <meta name="layout" content="homeLayout">
  </head>
  
    <body>
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
                </div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                      <li class="breadcrumb-item"><a href="${createLink(uri: '/admin/home')}">Home</a></li>
                      <li class="breadcrumb-item active" aria-current="page">Account Information</li>
                    </ol>
                </nav>
                <h1 class="display-4">Accounts Information</h1>
                    <div class="nav-tab-container">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                              <a class="nav-link active" id="home-tab" data-toggle="tab" href="#accountInfo" >Balance Inquiry</a>
                            </li>
                            <li class="nav-item">
                              <a class="nav-link" id="profile-tab" data-toggle="tab" href="#transHist" >Statement of Accounts</a>
                            </li>
<!--                                <li class="nav-item">
                              <a class="nav-link" id="profile-tab" data-toggle="tab" href="#soa" >Statement of accounts</a>
                            </li>-->
                        </ul>
                    </div>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="accountInfo" role="tabpanel" aria-labelledby="home-tab">
                           <br>
                              <div class="row">
                                    <table class="table table-striped table-hover">
                                    <tbody>
                                        <tr>
                                            <tr><td><b>First Name:</b> Juan</td></tr>
                                            <tr><td><b>Middle Name:</b> Singson</td></tr>
                                            <tr><td><b>Last Name:</b> Macapagal</td></tr>
                                            <tr><td><b>Account No.:</b> 12321hd1233</td></tr>
                                            <tr><td><b>Current Balance:</b> 100</td></tr>
                                            <tr><td><b>Available Balance:</b> 100</td></tr>
                                        </tr>
                                    </tbody>
                                  </table>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="transHist" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="row table-responsive">
                                  <table class="table table-hover">
                                      <thead>
                                        <tr>
                                          <th scope="col">Date</th>
                                          <th scope="col">Branch</th>
                                          <th scope="col">Description</th>
                                          <th scope="col">Debit</th>
                                          <th scope="col">Credit</th>
                                          <th scope="col">Balance</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">07/06/2018</th>
                                            <td>Ermita Branch</td>
                                            <td>ATM Withdrawal</td>
                                            <td>6,000</td>
                                            <td></td>
                                            <td>3,000</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">07/07/2018</th>
                                            <td>Makati Branch</td>
                                            <td>Bank Credit</td>
                                            <td></td>
                                            <td>2000</td>
                                            <td>3,000</td>
                                        </tr>
                                    </tbody>
                                  </table>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="soa" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="row table-responsive">
                                  <table class="table table-hover">
                                      <thead>
                                        <tr>
                                          <th scope="col">Date</th>
                                          <th scope="col">Branch</th>
                                          <th scope="col">Description</th>
                                          <th scope="col">Debit</th>
                                          <th scope="col">Credit</th>
                                          <th scope="col">Balance</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">07/06/2018</th>
                                            <td>Ermita Branch</td>
                                            <td>ATM Withdrawal</td>
                                            <td>6,000</td>
                                            <td></td>
                                            <td>3,000</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">07/07/2018</th>
                                            <td>Makati Branch</td>
                                            <td>Bank Credit</td>
                                            <td></td>
                                            <td>2000</td>
                                            <td>3,000</td>
                                        </tr>
                                    </tbody>
                                  </table>
                            </div>
                        </div>
                    </div>
            </div>
        </main>
    </body>
</html>