class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find_by_id params[:id]
    render "edit"
  end

  def create
     user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
     @user = User.new user_params
     if @user.save
       session[:user_id] = @user.id
       @user.generate_account_verification_data
       AccountVerificationsMailer.send_verification_instructions(@user).deliver_later
       render "users/account_verifications/create"
     else
       render :new
     end

   end

   def update
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
     @user = User.find(params[:id])
     if @user.update_attributes(user_params)
       redirect_to home_path, notice: "Profile updated!"
     else
       render 'update'
     end
   end

   def destroy
    user = User.find_by_id params[:id]
    session[:user_id] = nil
    user.destroy
    redirect_to root_path, notice: "User deleted!"
  end

end
