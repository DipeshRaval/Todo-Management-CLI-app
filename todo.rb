# todo.rb
require "active_record"

class Todo < ActiveRecord::Base
  def self.overdue
    where("due_date < ? ", Date.today)
  end

  def self.due_today
    where("due_date = ? ", Date.today)
  end

  def self.due_later
    where("due_date > ? ", Date.today)
  end

  def to_parse_string
    is_completed = completed ? "[x]" : "[ ]"
    date = due_date == Date.today ? nil : due_date
    "#{id}. #{is_completed} #{todo_text} #{date}"
  end

  def self.to_display_list_of_todos
    all.map { |todo| todo.to_parse_string }
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts overdue.map { |todo| todo.to_parse_string }
    puts "\n\n"

    puts "Due Today\n"
    puts due_today.map { |todo| todo.to_parse_string }
    puts "\n\n"

    puts "Due Later\n"
    puts due_later.map { |todo| todo.to_parse_string }
    puts "\n\n"
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
