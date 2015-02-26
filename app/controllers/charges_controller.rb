class ChargesController < ApplicationController

  def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Member - #{current_user.name}",
     amount: default_amount
   }
  end

  def create

    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: default_amount,
     description: "Premium Member - #{current_user.email}",
     currency: 'usd'
    )

    flash[:success] = "Congratulations, #{current_user.email}! You are now a premium member."
    current_user.update_attributes(:role => 'premium')
    redirect_to root_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  protected

  def default_amount
    15_00 #cost to upgrade to premium membership
  end

end
