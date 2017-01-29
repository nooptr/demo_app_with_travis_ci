class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.order("firstname").page(params[:page]).per(5)
  end 

  def new
    @user=User.new
    @roles = Role.all
    designation_list
    role_list 
  end

  def show
    @user = User.find(params[:id])
  end

  def edit 
    @user = User.find(params[:id])
    designation_list
    role_list
  end 

  def create
    captcha_message = "The data you entered for the CAPTCHA wasn't correct.  Please try again"
    @user =User.new(user_params)
    if !verify_recaptcha(model: @user, message: captcha_message)
      designation_list
      role_list
      render :new 
    else
      @user.save
      redirect_to admin_users_path(@user)
    end
  end

  def role_list
    @roles=Role.pluck(:id,:name)
  end
  def designation_list
     @designations=Designation.pluck(:id,:name)
  end

  def update
    @user = User.find(params[:id])
    designation_list
    role_list
    if @user.update(user_params)
      redirect_to [:admin,@user]
    else
      p @user.errors
      render 'edit'
    end  
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def unlock
    @user = User.find(params[:user_id])
    @user.reset_status
    flash[:notice] = "Account is Unlocked"
    redirect_to admin_users_path
  end

  private
    def user_params
      params.require(:user).permit(:remove_image,:firstname, :role_id,:designation_id ,:middlename, :previous_experiance_year,:previous_experiance_month,:lastname, :email, :username, :password, :password_confirmation, :empid, :dob, :timezone, :doj,  :gender, :education, :comments, :locked, :deactivated, :reason, :phone,:deactivated_date,:image)
    end
end
