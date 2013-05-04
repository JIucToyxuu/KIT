class CreateChairs < ActiveRecord::Migration
  def change
    create_table :chairs do |t|
      t.string :namechair
      t.integer :faculty_id

      t.timestamps
    end
  end
end
