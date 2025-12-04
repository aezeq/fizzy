module Account::Billing
  extend ActiveSupport::Concern

  included do
    has_one :subscription, class_name: "Account::Subscription", dependent: :destroy
  end

  def plan
    active_subscription&.plan || Plan.free
  end

  def active_subscription
    subscription if subscription&.active?
  end

  def subscribed?
    subscription&.stripe_customer_id.present?
  end

  def card_limit_exceeded?
    cards_count > plan.card_limit
  end
end
