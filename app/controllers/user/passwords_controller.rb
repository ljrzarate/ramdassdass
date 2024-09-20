class User::PasswordsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_password_with_password(user_params)
      sign_in @user, bypass: true
      redirect_to user_dashboard_path, flash: { success: "Successfully updated password" }
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

end