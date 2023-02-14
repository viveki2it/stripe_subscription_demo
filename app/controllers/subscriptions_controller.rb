class SubscriptionsController < ApplicationController
  def create_checkout_session
    stripe_credit_card_session = StripeDemo::Create.create_card({ email: params[:email] })
    redirect_to stripe_credit_card_session.url, allow_other_host: true
  rescue => e
    flash[:error] = "Sorry, something went wrong - #{e.message}"
    Rails.logger.error "Error occurred while trying to create checkout session: #{e.inspect}"
    redirect_to root_path
  end

  def success_checkout
    session = StripeDemo::Get.get_session(params[:session_id])

    unless session.present?
      flash[:error] = "Failed to collect credit card"
      return redirect_to root_path
    end
    if session.client_reference_id.present?
      user = User.find_by(id: session.client_reference_id)
      user&.update(stripe_id: session.customer)
    end

    @customer = StripeDemo::Get.get_customer(session.customer)
  end

  def cancel_checkout
    flash[:error] = "Failed to collect credit card"

    redirect_to root_path
  end
end
