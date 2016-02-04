class CreditCardsController < ApplicationController
  before_action :authenticate_user!

  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = CreditCard.new(credit_card_params)
  end

  private

  # strong params
  def credit_card_params
    params.require(:credit_card).permit(
      :user_id,
      :last_four_digits,
      :billing_address1,
      :billing_address2,
      :billing_city,
      :billing_state,
      :billing_zip
    )
  end
end
