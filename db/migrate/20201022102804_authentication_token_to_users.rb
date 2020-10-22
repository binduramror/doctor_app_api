class AuthenticationTokenToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :authentication_token, :string
  	add_column :appointments, :slot, :time
  end
end
