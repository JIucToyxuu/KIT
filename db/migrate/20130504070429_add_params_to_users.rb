class AddParamsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :family_name, :string
    add_column :users, :patronymic, :string
    add_column :users, :faculty, :string
    add_column :users, :chair, :string
    add_column :users, :branch, :string
    add_column :users, :year_off, :integer
  end
end
