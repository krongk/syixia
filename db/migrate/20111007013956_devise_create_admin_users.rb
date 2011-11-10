class DeviseCreateAdminUsers < ActiveRecord::Migration
  def self.up
    create_table(:admin_users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    # Create a default user
    AdminUser.create!(:email => 'master@inruby.com', :password => 'inruby', :password_confirmation => 'inruby')
    AdminUser.create!(:email => 'kenrome@inruby.com', :password => 'kenrome', :password_confirmation => 'kenrome')
    AdminUser.create!(:email => 'admin@syixia.com', :password => 'syixia_admin', :password_confirmation => 'syixia_admin')
    AdminUser.create!(:email => 'master@syixia.com', :password => 'syixia_master', :password_confirmation => 'syixia_master')
    AdminUser.create!(:email => 'customer@syixia.com', :password => 'syixia_customer', :password_confirmation => 'syixia_customer')

    add_index :admin_users, :email,                :unique => true
    add_index :admin_users, :reset_password_token, :unique => true
    #
    # add_index :admin_users, :confirmation_token,   :unique => true
    # add_index :admin_users, :unlock_token,         :unique => true
    # add_index :admin_users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :admin_users
  end
end
