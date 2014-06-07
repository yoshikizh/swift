class AddStbToUsers < ActiveRecord::Migration
  def change
    add_column :users,:stb, :integer, :default => 0
  end
end
