require "./connect_db.rb"

connect_db!

ActiveRecord::Migration.create_table(:todos) do |table|
  table.column :todo_text, :text
  table.column :due_date, :date
  table.column :completed, :bool
end
