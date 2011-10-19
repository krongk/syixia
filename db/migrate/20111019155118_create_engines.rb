class CreateEngines < ActiveRecord::Migration
  def change
    create_table :engines do |t|
      t.string :name
      t.string :nickname
      t.string :url
      t.string :scope
      t.string :description
      t.boolean :is_valid, :default => true

      t.timestamps
    end
  end
end
