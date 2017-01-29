class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :configure_sanitized_params, if: :devise_controller?
  
    def configure_sanitized_params
      devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:firstname, :designation_id ,:middlename, :previous_experiance_year,:previous_experiance_month,:lastname, :email, :username, :password, :password_confirmation, :previous_experiance,:empid, :dob, :timezone, :doj,  :gender, :education, :comments, :locked, :deactivated, :reason, :phone,:deactivated_date,:image)}
      devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:remove_image,:firstname, :designation_id ,:middlename, :lastname, :email, :username,  :empid, :dob, :timezone, :doj,  :gender, :education, :comments, :locked, :deactivated, :reason, :phone,  :deactivated_date,:image)}
      devise_parameter_sanitizer.for(:sign_in) {|u| u.permit( :email,:password,)}
    end
    
    rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to user_url(:id => current_user.id)
  end
end
