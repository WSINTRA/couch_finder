class Order < ActiveRecord::Base
	belongs_to :supplier_couch
	belongs_to :customer
end

#Tdod work on couch through suppliercouch