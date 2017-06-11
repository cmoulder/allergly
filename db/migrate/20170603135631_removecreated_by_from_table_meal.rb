class RemovecreatedByFromTableMeal < ActiveRecord::Migration[5.0]
  def change
    remove_column :Meals, :created_by
  end
end
