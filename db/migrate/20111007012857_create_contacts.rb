class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
