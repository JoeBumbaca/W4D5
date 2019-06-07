FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    password {'password123'}
  end

  factory :bob do
    username { 'Bob' }
    password { 'password123' }
  end
end
