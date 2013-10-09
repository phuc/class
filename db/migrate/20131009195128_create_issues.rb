class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :status
      t.integer :resolved_by
      t.timestamps
    end
    
    add_index :issues, :user_id
    add_index :issues, :resolved_by
    add_index :issues, :status
  end
end
