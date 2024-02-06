FactoryBot.define do
  factory :admin_user do
    email { 'mail@test.com' }
    password { "123456" }
  end
end
