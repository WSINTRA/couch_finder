class Customer < ActiveRecord::Base
has_many :orders, :dependent => :destroy


def compares
	#returns couches in budget
 

    SupplierCouch.select do |couchs|
    couchs.couch.length_in_ft < self.max_size && couchs.price < self.budget
    end.each {|item|
    puts " '#{item.couch.name}' is #{item.couch.length_in_ft}ft available from #{item.supplier.name} for $#{item.price}"
        puts "Please order with order id: #{item.id}"}

end

end