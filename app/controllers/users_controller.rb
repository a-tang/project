class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def new_customer
    @user = User.new
  end

  def edit_customer
    @user = User.find_by_id params[:id]
    render "edit"
  end

  def edit
    @user = User.find_by_id params[:id]
    render "edit"
  end

  def create

     @user = User.new user_params
     if @user.save
       session[:user_id] = @user.id
       @user.generate_account_verification_data
       AccountVerificationsMailer.send_verification_instructions(@user).deliver_later
       render "users/account_verifications/create"
     else
       if params[:user][:user_type] == "customer"
          render :new_customer
       else
         render :new
       end
     end

   end

   def update
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

  private

  def contests
    @user = User.find(params[:id])
    @contests = @user.contests
  end

  def user_params
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :company_name, :company_address, :company_overview, :company_phone_number, :company_website, :user_type)
  end

end
