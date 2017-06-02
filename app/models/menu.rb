class Menu < ApplicationRecord
  belongs_to :meal
  belongs_to :dish 
end
