class AddRolesToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :roles_mask, :integer, :after => "email"
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
