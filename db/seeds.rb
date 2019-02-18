Category.destroy_all
Job.destroy_all

8.times do |c|
  Category.create!(
    name: Faker::Company.industry
  )
end

puts '8 categories created'


20.times do |j|
  Job.create!(
    title: Faker::Company.catch_phrase,
    description: Faker::Hipster.paragraph(4),
    company: Faker::Company.name,
    url: Faker::Internet.url,
    category_id: rand(1..8)
  )
end

puts '20 jobs created'

