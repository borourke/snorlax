class Unit < ActiveRecord::Base
  belongs_to :project
  has_many :unit_data
end