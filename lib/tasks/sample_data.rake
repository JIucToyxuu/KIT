namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
  end
end

def make_users
  admin = User.create!(name:     "Admin",
                       email:    "admin@admin.ru",
                       password: "123456",
                       password_confirmation: "123456",
                       family_name: "_",
                       patronymic: "_",
                       faculty: "nill",
                       chair: "nill",
                       branch: "nill",
                       year_off: 2013)
  admin.toggle!(:admin)
end
