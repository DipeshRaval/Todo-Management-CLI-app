require "active_record"

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[x]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  def self.show_list
    puts "My Todo-list\n\n"
    puts "Overdue"
    puts Todo.where("due_date < ?", Date.today).to_displayable_list
    puts "\n\n"

    puts "Due Today"
    puts Todo.where(due_date: Date.today).to_displayable_list
    puts "\n\n"

    puts "Due Later"
    puts Todo.where("due_date > ?", Date.today).to_displayable_list
  end

  def self.add_task(todo_hash)
    Todo.create(todo_text: todo_hash[:todo_text].chomp, due_date: Date.today + todo_hash[:due_in_days], completed: false)
  end

  def self.mark_as_complete(todo_id)
    todo = Todo.find(todo_id)
    todo.completed = true
    todo.save
    todo
  end
end
