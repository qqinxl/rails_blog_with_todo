class CreateAdminTodoTags < ActiveRecord::Migration
  def change
    create_table :admin_todo_tags do |t|
      t.string :name
      t.boolean :static,  :default => false
      t.references :user

      t.timestamps
    end
    add_index :admin_todo_tags, :name, :unique => true
    add_index :admin_todo_tags, :static
    add_index :admin_todo_tags, :user_id
  end
end
