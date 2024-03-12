Institution.create!(
  name: 'manageR institute',
  location: 'none',
)

GradingSystem.create!(
  name: 'Bulgarian',
  start_grade: 2,
  end_grade: 6,
  step: 1,
  direction: :positive,
  description: 'Grading system used in Bulgaria',
  institution_id: Institution.first.id
)

2.times do
  IClass.create!(
    name: Faker::Educator.course_name,
    year: (1..5).to_a.sample,
    institution: Institution.first,
    description: Faker::Lorem.paragraphs(
      number: rand(5..50),
      supplemental: true,
    ).join("\n")
  )
end

User.create!(
  name: 'Petar Angelov',
  email: 'admin@example.com',
  password: '123456',
  bio: Faker::Books::Lovecraft.paragraphs(number: rand(2..7)).join("\n"),
  access_type: 5,
  institution: Institution.first,
  i_class: IClass.first,
)

4.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '123456',
    bio: Faker::Books::Lovecraft.paragraphs(number: rand(2..7)).join("\n"),
    access_type: rand(2..4), # teacher or student
    institution: Institution.first,
    i_class: IClass.first,
  )
end

6.times do
  Subject.create!(
    name: 'Test subject',
    year: (1..5).to_a.sample,
    description: Faker::Lorem.paragraphs(
      number: rand(5..50),
      supplemental: true,
    ).join("\n"),
    user: User.first,
    i_class: IClass.all.sample
  )
end

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
      bio: Faker::Books::Lovecraft.paragraphs(number: rand(2..7)).join("\n"),
      access_type: %w[student teacher].sample,
      institution: institution,
      i_class: IClass.for(institution).sample
    )
  end

  100.times do
    Subject.create!(
      name: Faker::Educator.subject,
      year: (1..5).to_a.sample,
      description: Faker::Lorem.paragraphs(
        number: rand(5..50),
        supplemental: true,
      ).join("\n"),
      user: User.all.sample,
      i_class: IClass.all.sample,
    )
  end

  AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456')
end
