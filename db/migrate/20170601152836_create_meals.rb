class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|

      t.integer :user_id

      t.date :date

      t.integer :mood


      t.timestamps

    end

  end
end
