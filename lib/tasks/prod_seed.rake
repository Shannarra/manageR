namespace :db do
  task seed_prod: :environment do
    if Rails.env.production?
      puts "[ERROR] db:seed_prod must be run ONLY on prod."

      exit(1)
    end

    Institution.create!(
      name: 'manageR institute',
      location: 'idk street ',
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
      2.times do
        User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: '123456',
          bio: Faker::Books::Lovecraft.paragraphs(number: rand(2..7)).join("\n"),
          access_type: 2, # student
          institution: Institution.first,
          i_class: IClass.first,
        )
      end

      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: '123456',
        bio: Faker::Books::Lovecraft.paragraphs(number: rand(2..7)).join("\n"),
        access_type: 3, # teacher
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
  end
end
