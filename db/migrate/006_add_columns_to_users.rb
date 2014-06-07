class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users,:utype, :string, :default => "normal"
    add_column :users,:point, :integer, :default => 50
    add_index :users, :utype
  end
end
