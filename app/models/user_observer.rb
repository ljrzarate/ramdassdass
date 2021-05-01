class UserObserver < ActiveRecord::Observer
  observe :user

  def after_save(user)
    #WelcomeEmailWorker.perform_async(user.id)
    WelcomeEmailJob.perform_later(user.id)
  end
end
