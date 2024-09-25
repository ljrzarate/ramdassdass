class User::DashboardsController < ApplicationController
  def show
    @private_chapters = Post.where(is_private: true).left_joins(:orders).where(orders: {user_id: nil})
  end
end