module ApplicationHelper
  RECAPTCHA_SITE_KEY = ENV['RECAPTACH_SITE_KEY']

  def main_image_banner_url_helper
    if @current_box && @current_box.image_to_show_on_main_banner.present?
      url_for(@current_box.image_to_show_on_main_banner)
    else
      asset_url('hanuman.jpg')
    end
  end

  def device
    agent = request.user_agent
    return :tablet if agent =~ /(tablet|ipad)|(android(?!.*mobile))/i
    return :mobile if agent =~ /Mobile/
    return :desktop
  end

  def include_recaptcha_js
    raw %Q{
      <script src="https://www.google.com/recaptcha/api.js?render=#{RECAPTCHA_SITE_KEY}"></script>
    }
  end

  def recaptcha_execute(action)
    id = "recaptcha_token_#{SecureRandom.hex(10)}"

    raw %Q{
      <input name="recaptcha_token" type="hidden" id="#{id}"/>
      <script>
        grecaptcha.ready(function() {
          grecaptcha.execute('#{RECAPTCHA_SITE_KEY}', {action: '#{action}'}).then(function(token) {
            document.getElementById("#{id}").value = token;
          });
        });
      </script>
    }
  end


	def flash_class(level)
    level = level.to_sym
    klasses = "col-12 col-sm-10 offset-sm-1 col-md-8 offset-md-2 alert"
    return "#{klasses} alert alert-info" if level == :notice
    return "#{klasses} alert alert-success" if level == :success
    return "#{klasses} alert alert-danger" if level == :error
    return "#{klasses} alert alert-danger" if level == :alert
  end
end
