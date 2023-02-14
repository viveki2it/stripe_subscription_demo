module StripeDemo
  module Get
    extend self
    extend StripeDemo::Main

    def get_session(id)
      Stripe::Checkout::Session.retrieve(id)
    end

    def get_customer(id)
      Stripe::Customer.retrieve(id)
    end

    def get_subscription(id)
      Stripe::Subscription.retrieve(id)
    end
  end
end
