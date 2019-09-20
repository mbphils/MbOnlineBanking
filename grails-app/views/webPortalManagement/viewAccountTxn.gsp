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
                  <li class="breadcrumb-item"><a href="${createLink(uri: '/admin/home')}">Home</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Accounts Transactions</li>
                </ol>
            </nav>
            <h3>Accounts Information</h3>
                <div class="card bg-light">
                    <div class="card-body">
                        <div class="table-responsive-sm">
                        <table class="table table-sm table-striped table-bordered table-hover">
                            <tbody>
                                <tr>
                                    <td class="font-weight-bold"><p> Customer Name</p></td>
                                    <td><p>${acctInformationValues?.clientdisplayName}</p></td>
                                    <td class="font-weight-bold"><p> Ledger Balance</p></td>
                                    <td><p><g:formatNumber format="###,###,##0.00" number="${acctInformationValues?.acctdepositLedger}"/></p></td>
                                </tr>
                                <tr>
                                    <td class="font-weight-bold"><p>Customer ID</p></td>
                                    <td><p>${acctInformationValues?.clientCustomerId}</p></td>
                                    <td class="font-weight-bold"><p> Available Balance</p></td>
                                    <td><p><g:formatNumber format="###,###,##0.00" number="${acctInformationValues?.acctdepositAvailable}"/></p></td>
                                </tr>
                                <tr>
                                    <td class="font-weight-bold"><p>Account No.</p></td>
                                    <td><p>${acctInformationValues?.acctdepositAcctNo}</p></td>
                                    <td class="font-weight-bold"><p> Uncleared Balance</p></td>
                                    <td><p><g:formatNumber format="###,###,##0.00" number="${acctInformationValues?.acctdepositUnclearedBalance}"/></p></td>
                                </tr>
                                <tr>
                                    <td class="font-weight-bold"><p>Deposit Type</p></td>
                                    <td><p >${acctInformationValues?.acctdepositType}</p></td>
                                    <td class="font-weight-bold "><p> Hold Balance</p></td>
                                    <td><p><g:formatNumber format="###,###,##0.00" number="${acctInformationValues?.acctdepositHoldBalance}"/></p></td>
                                </tr>
                                <tr>
                                    <td class="font-weight-bold"><p>Deposit Status</p></td>
                                    <td class="text-success font-weight-bold"><p>${acctInformationValues?.acctdepositStatus}</p></td>
                                </tr>
                            </tbody>
                        </table>
                        </div>
                    </div>
                </div>
                <h3>Accounts Transactions</h3>
                <div class="table-responsive">
                    <table id = "mattDatatable" class="table table-sm table-striped table-bordered table-hover">
                        <thead>
                          <tr>
                            <th scope="col">Txn Date</th>
                            <th scope="col">Branch</th>
                            <th scope="col">Description</th>
                            <th scope="col">Currency</th>
                            <th scope="col">Debit</th>
                            <th scope="col">Credit</th>
                            <th scope="col">Balance</th>
                          </tr>
                      </thead>
                      <tbody>
                            <g:each in="${jmdataHandler}" var="acctTransactionList">    
                            <tr>
                                <td><g:formatDate  format="MM/dd/yyyy" date="${acctTransactionList.txnDate}" /></td>
                                <td>${acctTransactionList.branch}</td>
                                <td>${acctTransactionList.txnDescription}</td>
                                <td>${acctTransactionList.currency}</td>

                                <td><g:formatNumber format="###,###,##0.00" number="${acctTransactionList.debitAmt}"/></td>
                                <td><g:formatNumber format="###,###,##0.00" number="${acctTransactionList.creditAmt}"/></td>
                                <td><g:formatNumber format="###,###,##0.00" number="${acctTransactionList.balance}"/></td>
                            </tr>
                        </g:each>  
                      </tbody>
                    </table>
                </div>
            </div>
        </main>
    </body>
</html>