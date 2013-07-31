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

  factory :domain do |d|
    d.name 'foo'
    d.association :user
  end

  factory :soa_section do |s|
    s.primary_domain_name "primary_domain_name"
  end

  factory :resource_record do |rr|
    rr.resource_type 'MX'
    rr.value 'mx.hostname.com'
    rr.option 1
  end

  factory :dns_zone do |d|
    origin 'foo.com'
    user
    domain { create(:domain, :name => 'example.com', :user => user) }
    soa_section { create(:soa_section, :user => user)}
    after(:create) do |d|
      create_list(:resource_record, 3, user: d.user, :dns_zone => d)
    end
  end
end
