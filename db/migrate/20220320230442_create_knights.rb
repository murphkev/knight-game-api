class CreateKnights < ActiveRecord::Migration[7.0]
  def change
    create_table :knights do |t|

      t.timestamps
    end
  end
end
