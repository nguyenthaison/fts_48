class AddStartedAtToExams < ActiveRecord::Migration
  def change
    add_column :exams, :started_at, :integer
  end
end
