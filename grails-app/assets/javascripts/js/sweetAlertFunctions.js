/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/*
 * 
 * RDM Customize sweetAlert Functions
 */
function errorSwal(message){
    swal({
        type: 'error',
        title: 'Oops...',
        text: message
    });
    // if you want to customize this swal function please go to https://sweetalert2.github.io/ for reference
}
function successSwal(message){
    swal({
        type: 'success',
        title: message,
        showConfirmButton: true
      });
}
function infoSwal(message,urlPage){
    swal({
        type: 'info',
        title: message,
        showConfirmButton: true
      }).then((result) => {
        if (result.value) {
            window.location.href = urlPage;
            
        }
      });
}
function confirmCancelSwal(formId){
    swal({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Submit!'       
      }).then((result) => {
        if (result.value) {
            swal(
              'Submitted!',
              'Your request has been Submitted.',
              'success', 
            ).then((result) => {
                // do something here
                
            });
        }else{
            swal(
              'Cancelled!',
              'Request has been Cancelled.',
              'error', 
            )
        }
      });
}
