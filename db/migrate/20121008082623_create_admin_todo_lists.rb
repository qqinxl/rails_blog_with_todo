class CreateAdminTodoLists < ActiveRecord::Migration
  def change
    create_table :admin_todo_lists do |t|
      t.string :name
      t.text :description
      t.boolean :starred, :default => false
      t.datetime :due_date
      t.datetime :completed_at
      t.datetime :deleted_at
      t.references :todo_tag
      t.references :user

      t.timestamps
    end
    add_index :admin_todo_lists, :name, :unique => true
    add_index :admin_todo_lists, :starred
    add_index :admin_todo_lists, :todo_tag_id
    add_index :admin_todo_lists, :user_id
  end
end
