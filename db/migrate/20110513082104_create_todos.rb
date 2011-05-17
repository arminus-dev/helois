class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.integer :user_id
      t.string :title
      t.float :expected_duration
      t.datetime :due_date
      t.boolean :completed

      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
