class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :id_message
      t.integer :id_user
      t.string :text_of_comment

      t.timestamps
    end
  end
end
