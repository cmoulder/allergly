class AddUserIdToMeal < ActiveRecord::Migration[5.0]
  def change
    add_column :dishes, :created_by, :integer
  end
end
