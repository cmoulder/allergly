class Meal < ApplicationRecord
  belongs_to :user
  has_many :menus, :dependent => :destroy
  has_many :dishes, :through => :menus
end
