class Recipe < ApplicationRecord
  belongs_to :dish
  belongs_to :ingredient
  validates :ingredient_id, :presence => true
  validates :dish_id, :presence => true 
end
