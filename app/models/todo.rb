class Todo < ActiveRecord::Base
  belongs_to  :user
  simple_column_search :title
  validates_presence_of :expected_duration, :title
  validates_presence_of :due_date , :if => "!completed"
  scope :filter_own_todos, lambda { |user_id| where('user_id = ?', user_id)}
  scope :unfinished_todos, lambda { |user_id| where('user_id = ? and completed = ?', user_id, false)}
  self.per_page = 10
end
