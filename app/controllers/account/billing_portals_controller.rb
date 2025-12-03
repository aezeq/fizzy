class Account::BillingPortalsController < ApplicationController
  before_action :ensure_admin

  def show
    unless Current.account.subscription&.stripe_customer_id
      redirect_to account_subscription_path, alert: "No billing information found"
      return
    end

    session = Stripe::BillingPortal::Session.create(
      customer: Current.account.subscription.stripe_customer_id,
      return_url: account_subscription_url
    )

    redirect_to session.url, allow_other_host: true
  end
end
