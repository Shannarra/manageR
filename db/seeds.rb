Institution.create!(
  name: 'manageR',
  location: 'none',
)

IClass.create!(
  name: Faker::Educator.course_name,
  year: (1..5).to_a.sample,
  institution: Institution.first,
  description: Faker::Lorem.paragraphs(
    number: rand(5..50),
    supplemental: true,
  ).join("\n")
)

User.create!(
  name: 'Petar Angelov',
  email: 'admin@example.com',
  password: '123456',
  access_type: 5,
  institution: Institution.first,
  i_class: IClass.first,
)

unless Rails.env.production?
  5.times do
    Institution.create!(
      name: Faker::University.name,
      location: Faker::Address.street_address,
      code: SecureRandom.alphanumeric(20)
    )

    10.times do
      IClass.create!(
        name: Faker::Educator.course_name,
        year: (1..5).to_a.sample,
        institution: Institution.all.sample,
        description: Faker::Lorem.paragraphs(
          number: rand(5..50),
          supplemental: true,
        ).join("\n")
      )
    end
  end

  100.times do
    institution = Institution.last(5).sample

    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "123456",
      gender: %w[male female].sample,
      access_type: %w[student teacher].sample,
      institution: institution,
      i_class: IClass.for(institution).sample
    )
  end

  AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456')
end
