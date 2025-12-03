class Account::BillingPortalsController < ApplicationController
  before_action :ensure_admin
  before_action :ensure_account_has_subscription

  def show
    session = Stripe::BillingPortal::Session.create(customer: Current.account.subscription.stripe_customer_id, return_url: account_subscription_url)
    redirect_to session.url, allow_other_host: true
  end

  private
    def ensure_account_has_subscription
      unless Current.account.subscribed?
        redirect_to account_subscription_path, alert: "No billing information found"
      end
    end
end
