puts "🌱 Seeding data..."

5.times do
    user = User.create(
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      email: Faker::Internet.email,
      password_hash: Faker::Internet.password(min_length: 8),
      username: Faker::Internet.username,
      job: Faker::Job.title
    )
    
    used_values = []
    rand(1..10).times do
        faker = Faker::UniqueGenerator.new( used_values: used_values)
        unique_field = faker.job.field
        used_values << unique_field
      skill = Skill.create(
        name: unique_field,
        tools: Faker::ProgrammingLanguage.name,
        user_id: user.id
      )
    end
  
    rand(1..5).times do
      project = Project.create(
        name: Faker::App.name,
        image_src: Faker::LoremFlickr.image(size: "300x300"),
        description: Faker::Lorem.sentence(word_count: 10),
        site_link: Faker::Internet.url,
        git_link: Faker::Internet.url,
        user_id: user.id
      )
    end
  end


puts "🌱 Done seeding!"