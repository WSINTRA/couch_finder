class SupplierCouch < ActiveRecord::Base
	has_many :orders
	belongs_to :couch #contains length attribute
	belongs_to :supplier #contains price attribute
end