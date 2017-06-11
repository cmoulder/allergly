class Meal < ApplicationRecord
  belongs_to :user
  has_many :menus, :dependent => :destroy
  has_many :dishes, :through => :menus
  validates :mood, :numericality => { :less_than_or_equal_to => 2, :greater_than_or_equal_to => 0 }
  validates :mood, :presence => true
  validates :date, :presence => true 
end
