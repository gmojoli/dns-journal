class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Devise and Strong Parameters
  # sanitize here the parameters
  # https://github.com/plataformatec/devise#strong-parameters
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # cancan:
  # check_authorization

  before_filter do
    # https://github.com/ryanb/cancan/issues/835
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :surname << :username
    devise_parameter_sanitizer.for(:account_update) << :name << :surname << :username
  end
end
