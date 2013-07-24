FactoryGirl.define do

  sequence :sentence, aliases: [:title, :content] do
    Faker::Lorem.sentence
  end

  sequence :name, aliases: [:file_name] do
    Faker::Name.name
  end

  sequence(:url) { Faker::Internet.uri('http') }

  factory :user do
    before(:create) do
      create(:role, :name => 'user')
    end
    email { Faker::Internet.email }
    name
    password "123456789"
    password_confirmation { password }

    trait :admin do
      after(:create) do |user|
        user.roles << FactoryGirl.create(:role, :name => "admin")
      end
    end

    factory :admin, traits: [:admin]
  end

  factory :role do
    name
  end
end