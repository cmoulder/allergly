class Dish < ApplicationRecord
  has_many :recipes
  has_many :ingredients, :through => :recipes
  has_one :creator, primary_key: "created_by", foreign_key: "id", class_name: "User"

  has_many :menus
  has_many :meals, :through => :menus

  validates :name, :presence => true
  validates :name, :uniqueness => true
end
