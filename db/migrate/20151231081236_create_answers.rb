class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :content
      t.integer :is_correct
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
