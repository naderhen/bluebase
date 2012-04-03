# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
User.delete_all
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Nader Hendawi', :email => 'naderhen@gmail.com', :password => 'krock923', :password_confirmation => 'krock923', :role => "Admin"
puts 'New user created: ' << user.name

user = User.create! :name => 'Warehouse Grader', :email => 'warehouse@bigblue.com', :password => 'bigblue', :password_confirmation => 'bigblue', :role => "Warehouse Grader"
puts 'New user created: ' << user.name

user = User.create! :name => 'Big Blue Staff', :email => 'bigblue@bigblue.com', :password => 'bigblue', :password_confirmation => 'bigblue', :role => "Staff"
puts 'New user created: ' << user.name

Warehouse.delete_all
["MIT", "PAN", "NOR", "TDW", "BFT", "ACA", "CUS", "ARA", "FDA", "LAW", "NFFM", "PEN", "PRY", "SEA", "FTW"].each do |warehouse|
	Warehouse.create! short_name: warehouse
	puts warehouse + ' warehouse created!'
end

Airport.delete_all
["JFK", "EWR", "ATL", "IAD", "MIA", "LAX"].each do |airport|
	Airport.create! short_name: airport
	puts airport + ' airport created!'
end

ItemCode.delete_all
CSV.foreach("#{Rails.root}/public/codes2.csv") do |row|
	ItemCode.create! code: row[0].to_s.strip, species: row[1].to_s.strip, subspecies: row[2].to_s.strip
	puts row[0]
end

Shipper.delete_all
10.times do
	shipper = Shipper.create! name: Faker::Name.name, email: Faker::Internet.email, phone: Faker::PhoneNumber.phone_number
	puts 'New Shipper Created: ' << shipper.name
end

Customer.delete_all
100.times do
	customer = Customer.create! name: Faker::Name.name
	puts 'New Customer Created: ' << customer.name
end

Purchaseorder.delete_all
Item.delete_all
Attachment.delete_all
(2400..2450).each_with_index do |num, index|
	shipper = Shipper.all.shuffle[0]
	date = Date.today - (30 - index)
	warehouse = Warehouse.all.shuffle[0]
	airport = Airport.all.shuffle[0]
	po = shipper.purchaseorders.create! po_number: num, po_date: date, warehouse_id: warehouse.id, airport_id: airport.id

	box_nums = (100...200).to_a
	item_nums = (1...6).to_a
	weights = (60...200).to_a
	grades = ['1+', '1', '2+', '2H', '2', '3', '4']

	itemcode = ItemCode.all.shuffle[0]

	(1...box_nums[rand(box_nums.size)]).each do |num, index|
		(1...item_nums[rand(item_nums.size)]).each do |num2, index2|
			po.items.create! box_number: num, item_number: num2, code: itemcode.code, weight: weights[rand(weights.size)], core_grade: grades[rand(grades.size)]
		end 
	end

	puts "New PO Created: #{po.po_number} #{po.po_date} -- #{shipper.name} -- Warehouse: #{po.warehouse_id} -- Airport: #{po.airport_id}"
end
