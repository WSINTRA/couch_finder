class Couch < ActiveRecord::Base
has_many :supplier_couches
has_many :suppliers, through: :supplier_couches
has_many :orders, through: :supplier_couches

end