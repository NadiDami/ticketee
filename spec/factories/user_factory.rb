FactoryGirl.define do
  factory :user do
    name "Example"
    email "user@example.com"
    password "password"
    password_confirmation "password"

    factory :admin_user do
      admin true
    end
  end
end