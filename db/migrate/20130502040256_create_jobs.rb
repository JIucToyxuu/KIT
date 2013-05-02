class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :namecompany
      t.string :address
      t.string :post
      t.boolean :active
      t.integer :user_id

      t.timestamps
    end
    add_index :jobs, [:user_id, :created_at]
  end
end
