Institution.create!(
  name: 'manageR',
  location: 'none',
)

User.create!(
  name: 'Petar Angelov',
  email: 'admin@example.com',
  password: '123456',
  access_type: 5,
  institution: Institution.first
)

unless Rails.env.production?
  5.times do
    Institution.create!(
      name: Faker::University.name,
      location: Faker::Address.street_address
    )
  end

  100.times do
    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "123456",
      gender: %w[male female].sample,
      access_type: %w[student teacher].sample,
      institution: Institution.last(5).sample
    )
  end

  AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456')
end
