class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :about]
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
    # 新規登録後投稿一覧画面へ行くように変更する
    # ユーザ情報詳細へ行くよう変更する
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
end
