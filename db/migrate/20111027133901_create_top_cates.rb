class CreateTopCates < ActiveRecord::Migration
  def change
    create_table :top_cates do |t|
      t.string :name
      t.boolean :is_valid, :default => true

      t.timestamps
    end

    add_index :top_cates, :name
  end
end
