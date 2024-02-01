AdminUser.create!(
  name: 'Petar Angelov',
  email: 'admin@example.com',
  password: '123456',
  access_type: 5
)

User.create!(
  name: 'Petar Angelov',
  email: 'admin@example.com',
  password: '123456',
  access_type: 5
)

100.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456",
    gender: %w[male female].sample,
    access_type: %w[student teacher].sample,
  )
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
