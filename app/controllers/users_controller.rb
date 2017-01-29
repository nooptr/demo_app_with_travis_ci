class UsersController < ApplicationController
  
  def index
	  # @users=User.all
   #  designation_list
   #  role_list
  end	

  def new
	 @user=User.new
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
    @user =User.new(user_params)
    if @user.save
	   redirect_to user_path(@user)
	 else
	   designation_list
     role_list
	   render :new
	 end
  end

  def update
    @user = User.find(params[:id])
    designation_list
    role_list
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end  
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def role_list
    @roles=Role.pluck(:id,:name)
  end
  def designation_list
     @designations=Designation.pluck(:id,:name)
  end

  private
  def user_params
    params.require(:user).permit(:user_image,:firstname,:role_id, :designation_id ,:middlename, :lastname, :email, :username, :encrypted_password, :password_confirmation, :empid, :dob, :timezone, :doj,  :gender, :education, :comments, :locked, :deactivated, :reason, :phone, :deactivated_date,:image)
  end
end
