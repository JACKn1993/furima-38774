class CreateRops < ActiveRecord::Migration[6.0]
  def change
    create_table :rops do |t|
      t.integer :user_id, null: false
      t.integer :item_id, null: false
      t.timestamps
    end
  end
end
