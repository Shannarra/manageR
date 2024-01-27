User.create!(
  name: 'Petar Angelov',
  email: 'admin@example.com',
  password: '123456',
  access_type: 5
)

10.times do |item|
  User.create!(
    name: "User #{item}",
    email: "mail#{item}@mail.com",
    password: "123456",
    gender: %w[male female].sample,
    access_type: %w[student teacher].sample,
  )
end
