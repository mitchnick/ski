class NotificationsMailer < ActionMailer::Base

  default :to => "mitch@wheretoski.co"
  default :from => "info@wheretoski.co"

  def contact_us(message)
    @message = message
    mail(	:subject => "New Message received from #{message.name}", 
    			:from => message.email)
  end

end