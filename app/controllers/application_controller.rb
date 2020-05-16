class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_sign_in_path_for(resource)
    user_path(resource) # ログイン後に遷移するpathを設定
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

  private
  def ensure_correct_user
    if current_user.id !=  params[:id].to_i
       redirect_to user_path(params)
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction])
  end

end
