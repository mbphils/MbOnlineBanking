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
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                      <li class="breadcrumb-item"><a href="${createLink(uri: '/admin/home')}">Home</a></li>
                      <li class="breadcrumb-item active" aria-current="page">Pay Bills</li>
                    </ol>
                </nav>
                <h1 class="display-4">Pay Bills</h1>
                <div class="row">
                    <div class="col-12 col-md-8">
                        <form  class="needs-validation" novalidate >
                            <div class="form-group ">
                                <label for="inputState">Make a Payment</label>
                                <select id="inputState" class="form-control">
                                  <option selected>Choose...</option>
                                    <option id="option_1" value="option_1">New Biller</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="validationCustom03">Amount</label>
                                <input type="number" class="form-control" id="validation1" placeholder="0.00" required>
                            </div>
                            <div class="form-group ">
                                <label for="inputState">Pay Using</label>
                                <select id="inputState" class="form-control">
                                  <option selected>Choose...</option>
                                    <option id="option_1" value="option_1">ATM</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="validationCustom04">Remarks</label>
                                <input type="text" class="form-control" id="validation1" placeholder="Remarks" required>
                            </div>
                            <button class="btn btn-primary" id="validation7" type="submit">Submit form</button>
                        </form>
                        <br>
                    </div>
                    <div class="col">
                        <div class="card bg-light mb-3" style="max-width: 30rem;">
                            <div class="card-header">Actions</div>
                            <div class="card-body">
                                <div class="list-group">
                                    <g:link action="transferFunds" controller="webPortalManagement" class="list-group-item list-group-item-action  list-group-item-default" ><h6><i class="fa fa-exchange"></i> Transfer Funds</h6></g:link>
                                    <g:link action="paybills" controller="webPortalManagement" class="list-group-item list-group-item-action active" ><h6><i class="fa fa-plus-circle"></i> Pay Bills</h6></g:link>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>