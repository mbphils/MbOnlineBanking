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
                      <li class="breadcrumb-item active" aria-current="page">View Registration</li>
                    </ol>
                </nav>
                <h1 class="display-4">Accounts Information</h1>
                <div class="row">
                    <div class="col-12 col-md-8">
                        <table class="table table-striped table-bordered table-hover">
                            <tbody>
                                <tr><td><label><b>Customer ID:</b> 12345</label></td></tr>
                                <tr><td><label><b>First Name:</b> Juan</label></td></tr>
                                <tr><td><label><b>Middle Name:</b> Singson</label></td></tr>
                                <tr><td><label><b>Last Name:</b> Macapagal</label></td></tr>
                                <tr><td><label><b>Address:</b> kalaw st. ermita manila </label></td></tr>
                                <tr><td><label><b>Username:</b> juan12345</label></td></tr>
                                <tr><td><label><b>Contact Number: </b> 09123456789 </label></td></tr>
                                <tr><td><label><b>Birthday: </b> 06/14/1997 </label></td></tr>
                                <tr><td><label><b>Email: </b> email@gmail.com </label></td></tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-6 col-md-4">
                        <div class="card bg-light mb-3" style="max-width: 30rem;">
                            <div class="card-header">Actions</div>
                            <div class="card-body">
                                <div class="list-group">
                                    <g:link action="registration" controller="admin" class="list-group-item list-group-item-action list-group-item-default " ><h6><i class="fa fa-list-alt"></i> Back to registration form</h6></g:link>
                                    <g:link action="login" controller="admin" class="list-group-item list-group-item-action list-group-item-default" ><h6><i class="fa fa-plus-circle"></i> Login Form</h6></g:link>
                                  
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>