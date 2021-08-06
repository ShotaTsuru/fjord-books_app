# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: %i[user_name postalcode address introduction]
    )
    devise_parameter_sanitizer.permit(
      :account_update, keys: %i[user_name postalcode address introduction]
    )
  end
end
