require "stripe"
require 'net/http'

module StripeDemo
  module Main
    Stripe.api_key = ENV['STRIPE_API_KEY']
    extend self
  end
end
