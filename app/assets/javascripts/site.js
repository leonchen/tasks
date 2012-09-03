$(function () {
  var pageResource = window.location.pathname.split("/")[1];
  $("#mainMenu a[href='/"+pageResource+"']").addClass("current");

  var $messages = $('#messages').find(">p");
  if ($messages.length) setTimeout(function () {
    $('#messages').fadeOut('slow');
  }, 3000);

  $('.create').click(function () {
    $('#entityForm').toggle();
  });
  $('.cancelButton').click(function () {
    var $createForm = $('#entityForm');
    if ($createForm.length) {
      $createForm.hide();
      $createForm.find('>form').resetForm();
    } else {
      window.history.back();
    }
  });
});
