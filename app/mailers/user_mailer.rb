class UserMailer < ActionMailer::Base
default :from => "odmin.srstu.2013@yandex.ru"
  
  def registration_confirmation(user)
    mail(:to => "odmin.srstu.2013@yandex.ru", :subject => "Registered")
  end
end
