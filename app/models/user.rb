class User < ApplicationRecord
  has_many :subscriptions, dependent: :destroy

  def subscribed?
    subscriptions.where(status: 'active').any?
  end
end
