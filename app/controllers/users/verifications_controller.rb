class Users::VerificationsController < ApplicationController
  def create
    Current.user.verify
    head :ok
  end
end
