module StripeDemo
  module Create
    extend self
    extend StripeDemo::Main

    def create_card(options = {})
      user = User.find_or_create_by!(email: options[:email])
      data = {
        customer: user.stripe_id,
        client_reference_id: user.id,
        line_items: [{
                       price: ENV['STRIPE_PRICE_ID'],
                       quantity: 1,
                     }],
        mode: 'subscription',
        payment_method_types: ['card'],
        customer_email: user.email,
        success_url: "#{ENV['CHECKOUT_BASE_URL']}/subscriptions/success_checkout?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: "#{ENV['CHECKOUT_BASE_URL']}/subscriptions/cancel_checkout",
      }

      Stripe::Checkout::Session.create(data)
    rescue => e
      Rails.logger.error "Error occurred while trying to create checkout session: #{e.inspect}"
      raise e.message
    end
  end
end
