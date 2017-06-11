class Ingredient < ApplicationRecord
  has_many :recipies
  has_many :dishes, :through => :recipes

  validates :name, :presence => true
  validates :name, :uniqueness => true
end
