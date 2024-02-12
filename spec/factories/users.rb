FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "123456" }
    gender { %w[male female].sample }
    access_type { %w[student teacher].sample }
    institution { create(:institution) }
    i_class { create(:i_class) }
  end
end
