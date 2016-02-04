$(document).ready(function() {
  $("#new_order").submit(function(event) {
    var $form = $(this);
    $form.find("input[type=submit]").prop("disabled", true);
    Stripe.card.createToken($form, stripeResponseHandler);
    return false;
  });
});

stripeResponseHandler = function(status, response) {
   var $form = $("#new_order");

   if (response.error) {
     $form.find('.payment-errors').text(response.error.message);
     $form.find("input[type=submit]").prop("disabled", false);
   } else {
     var token = response.id;
     $form.append($('<input type="hidden" name="stripeToken" />').val(token));
    //  $("[data-stripe=number]").remove();
    //  $("[data-stripe=cvv]").remove();
    //  $("[data-stripe=exp-year]").remove();
    //  $("[data-stripe=exp-month]").remove();
     $form.get(0).submit();
   }
  //  return false;
 };
