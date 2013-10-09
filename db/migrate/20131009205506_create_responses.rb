class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :issue_id
      t.text :message

      t.timestamps
    end
    
    add_index :responses, :user_id
    add_index :responses, :issue_id
  end
end
