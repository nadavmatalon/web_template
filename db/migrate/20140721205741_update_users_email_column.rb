class UpdateUsersEmailColumn < ActiveRecord::Migration
  def change
	change_column :users, :email, :string, :default => ""
  end
end
