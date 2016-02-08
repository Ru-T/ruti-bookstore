$(document).ready(function() {
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

  $("#new_order").submit(function(event) {
    var $form = $(this);
    $form.find("button").prop("disabled", true);
    if ($("#card_number").length) {
      Stripe.card.createToken($form, stripeResponseHandler);
      return false;
  } else {
      return true;
    }
  });
});

stripeResponseHandler = function(status, response) {
   var $form = $("#new_order");

   if (response.error) {
     $form.find('.payment-errors').text(response.error.message);
     $form.find("button").prop("disabled", false);
   } else {
     var token = response.id;
     $form.append($('<input type="hidden" name="stripeToken" />').val(token));
     $form.get(0).submit();
   }
 };
