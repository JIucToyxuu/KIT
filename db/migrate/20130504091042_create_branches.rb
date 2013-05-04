class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :namebranch
      t.integer :chair_id

      t.timestamps
    end
  end
end
