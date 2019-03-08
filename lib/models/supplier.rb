class Supplier < ActiveRecord::Base
has_many :supplier_couches
has_many :couchs, through: :supplier_couches
has_many :orders, through: :supplier_couches
end