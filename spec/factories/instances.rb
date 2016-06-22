FactoryGirl.define do
  factory :instance do
    sequence(:name) { |n| "server-#{n}" }
    sequence(:url) { |n| "http://server-#{n}.com" }
    sequence(:token) { |n| "token#{n}" }
  end
end
