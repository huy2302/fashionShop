// Alert Redirect to Another Link
$(document).on('click', '#link', function(e) {
  swal({
      title: "You want to sign out?", 
      text: "You will be redirected to login page", 
      type: "warning",
      confirmButtonText: "Log out",
      showCancelButton: true
  })
      .then((result) => {
          if (result.value) {
              window.location = './logout.asp';
          } else if (result.dismiss === 'cancel') {
              swal(
                'Cancelled',
                'Your stay here :)',
                'error'
              )
          }
      })
});
// Alert Modal Type
$(document).on('click', '#success', function(e) {
    swal(
        'Success',
        'You clicked the <b style="color:green;">Success</b> button!',
        'success'
    )
});

$(document).on('click', '#error', function(e) {
    swal(
        'Error!',
        'You clicked the <b style="color:red;">error</b> button!',
        'error'
    )
});

$(document).on('click', '#warning', function(e) {
    swal(
        'Warning!',
        'You clicked the <b style="color:coral;">warning</b> button!',
        'warning'
    )
});

$(document).on('click', '#info', function(e) {
    swal(
        'Info!',
        'You clicked the <b style="color:cornflowerblue;">info</b> button!',
        'info'
    )
});

$(document).on('click', '#question', function(e) {
    swal(
        'Question!',
        'You clicked the <b style="color:grey;">question</b> button!',
        'question'
    )
});
