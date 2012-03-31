# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    purchaseorder_id 1
    box_number 1
    item_number 1
    weight 1.5
    code "MyString"
    cost 1.5
    grade_notes "MyString"
    description "MyString"
    species "MyString"
    subspecies "MyString"
    shipper_grade "MyString"
    core_grade "MyString"
    freshness_grade "MyString"
    texture_grade "MyString"
    tail_grade "MyString"
  end
end
