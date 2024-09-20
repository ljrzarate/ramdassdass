class User::PasswordsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_password_with_password(user_params)
      sign_in @user, bypass: true
      redirect_to user_dashboard_path, flash: { success: "Successfully updated password" }
    else
      redirect_to user_dashboard_path, flash: { alert: @user.errors.full_messages.to_sentence }
    end
  end

  private

  def user_params
    params.permit(:current_password, :password, :password_confirmation)
  end

end