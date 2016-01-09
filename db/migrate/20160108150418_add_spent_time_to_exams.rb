class AddSpentTimeToExams < ActiveRecord::Migration
  def change
    add_column :exams, :spent_time, :integer
  end
end
