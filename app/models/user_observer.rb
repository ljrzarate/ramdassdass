class UserObserver < ActiveRecord::Observer
  observe :user

  def after_create(user)
    # random_pass = "please_change_#{SecureRandom.hex}"
    # binding.pry
    # nil + 1
    # user.password              = random_pass
    # user.password_confirmation = random_pass
    # user.payer_id              = random_pass
    # user.save!
    WelcomeEmailJob.perform_later(user.id)
  end
end
