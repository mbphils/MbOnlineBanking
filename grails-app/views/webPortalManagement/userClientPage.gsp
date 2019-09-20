<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>[Online Banking]</title>
    <meta name="layout" content="homeLayout">
  </head>
<body>
    <div class="container">
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
              <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
              <div class="carousel-item active">
                <div class="jumbotron text-center rounded bg-dark ">
                    <h1 class="display-4 font-italic text-danger font-weight-bold animated fadeInDownBig">MB Web-Portal</h1>
                        <p class="lead text-white font-weight-bold animated fadeInRightBig">Features of MB Web-Portal That Will Make You Interested</p>
                        <p class="text-white font-italic animated fadeInLeftBig">Thank you for logging in. Be sure to come back !!</p>
                        <p class="lead"></p>
                </div>
              </div>
              <div class="carousel-item">
                <div class="jumbotron text-center rounded bg-dark ">
                    <h1 class="display-4 font-italic text-danger font-weight-bold animated fadeInDownBig">MB Web-Portal</h1>
                        <p class="lead text-white font-weight-bold animated fadeInRightBig">Features of MB Web-Portal That Will Make You Interested</p>
                        <p class="text-white font-italic animated fadeInLeftBig">Thank you for logging in. Be sure to come back !!</p>
                        <p class="lead"></p>
                </div>
              </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="sr-only">Next</span>
            </a>
        </div>
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
        <br>
        <h3 class="pb-4 mb-4 border-bottom text-title1 border-info">
             Account Information
        </h3>
        <div class="row">
            <div class="col-sm-6">
                <div class="row no-gutters border rounded border-secondary overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                    <div class="col p-4 d-flex flex-column position-static">
                        <strong class="d-inline-block mb-2 text-primary">Customer Information</strong>
                        <h5 class="mb-0 " >Customer ID</h5>
                        <div class="mb-1 text-muted">${encryptCustomerId}</div>
                        <div class="row">
                            <div class="col-sm-6">
                                <h5 class="mb-0 " >Customer name</h5>
                                <div class="mb-1 text-muted" style="text-transform: capitalize;">${displayName}</div>
                            </div>
                            <div class="col-sm-6">
                                <h5 class="mb-0 " >Customer address</h5>
                                <div class="mb-1 text-muted" style="text-transform: capitalize;">${homeAddress}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="row no-gutters border rounded border-secondary overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position">
                    <div class="col p-4 d-flex flex-column position-static">
                        <strong class="d-inline-block mb-2 text-primary">Accounts Summary</strong>
                        <table>
                            <tr>
                                <td><h5 class="mb-0">Deposit Accounts</h5></td>
                                <td><span class="badge badge-warning">9</span></td>  
                            </tr>
                            <tr>
                                <td><h5 class="mb-0">Loan Accounts</h5></td>
                                <td><span class="badge badge-warning">2</span></td>  
                            </tr>
                            <tr>
                                <td><h5 class="mb-0">Total of Accounts</h5></td>
                                <td><span class="badge badge-warning">11</span></td>  
                            </tr>
                        </table>
                        <br>
                    </div>
                </div>
            </div>
        </div>
        <h3 class="pb-4 mb-4 border-bottom text-title1 border-info">
            Deposit Accounts
        </h3>
        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">First</th>
                  <th scope="col">Last</th>
                  <th scope="col">Handle</th>
                  <th scope="col">Action</th>

                </tr>
            </thead>
            <tbody>
                <tr>
                    <th scope="row">1</th>
                    <td>Mark</td>
                    <td>Otto</td>
                    <td>@mdo</td>
                    <td><g:link class="btn btn-primary" action="viewDeposit" controller="webPortalManagement" id="${params.id}">View Details</g:link></td>

                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>Jacob</td>
                    <td>Thornton</td>
                    <td>@fat</td>
                    <td><button class="btn btn-primary"><g:link action="viewDeposit" controller="webPortalManagement" id="${params.id}"></g:link>View Details</button></td>


                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                    <td><button class="btn btn-primary"><g:link action="viewDeposit" controller="webPortalManagement" id="${params.id}"></g:link>View Details</button></td>


                </tr>
            </tbody>
        </table>
        <h3 class="pb-4 mb-4 border-bottom text-title1 border-info">
            Loan Accounts
        </h3>
        <table class="table table-striped table-bordered">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">First</th>
                <th scope="col">Last</th>
                <th scope="col">Handle</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">1</th>
                <td>Mark</td>
                <td>Otto</td>
                <td>@mdo</td>
              </tr>
              <tr>
                <th scope="row">2</th>
                <td>Jacob</td>
                <td>Thornton</td>
                <td>@fat</td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>Larry</td>
                <td>the Bird</td>
                <td>@twitter</td>
              </tr>
            </tbody>
        </table>
    </div>
</body>
</html>