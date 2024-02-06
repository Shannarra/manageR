FactoryBot.define do
  factory :user do
    name { 'Fake name' }
    email { 'mail@test.com' }
    password { "123456" }
    gender { %w[male female].sample }
    access_type { %w[student teacher].sample }
    institution { create(:institution) }
  end
end
