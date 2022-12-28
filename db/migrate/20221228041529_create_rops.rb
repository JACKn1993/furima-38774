class CreateRops < ActiveRecord::Migration[6.0]
  def change
    create_table :rops do |t|

      t.timestamps
    end
  end
end
