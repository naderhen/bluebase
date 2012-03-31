# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchaseorder do
    po_number 1
    po_date "2012-03-30"
    shipper_id 1
    active false
    locale "MyString"
    origin "MyString"
    airline "MyString"
    customs_broker "MyString"
    date_of_arrival "2012-03-30"
    warehouse_id 1
    airport_id 1
  end
end
