class CreateCates < ActiveRecord::Migration
  def change
    create_table :cates do |t|
      t.string :name
      t.integer :parent_id, :default => 0

      t.timestamps
    end

    add_index :cates, :name
  end
end
