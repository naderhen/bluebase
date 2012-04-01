# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    user_id 1
    target_type "MyString"
    target_id 1
    target_action "MyString"
  end
end
