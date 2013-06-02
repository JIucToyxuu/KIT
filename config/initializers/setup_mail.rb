ActionMailer::Base.smtp_settings = {
   :address              => "smtp.gmail.com",
   :port                 => 587,
   :domain               => "blooming-badlands-7238.herokuapp.com",
   :user_name            => "odmin.srstu.2013@yandex.ru",
   :password             => "123456",
   :authentication       => "plain",
   :enable_starttls_auto => true
}