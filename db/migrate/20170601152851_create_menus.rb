class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|

      t.integer :meal_id

      t.integer :dish_id


      t.timestamps

    end

  end
end
