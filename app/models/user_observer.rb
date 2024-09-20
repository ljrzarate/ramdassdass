class UserObserver < ActiveRecord::Observer
  observe :user

  def after_create(user)
    #WelcomeEmailJob.perform_later(user.id)
  end
end
