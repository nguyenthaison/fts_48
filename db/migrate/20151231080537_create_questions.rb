class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :subject_id
      t.integer :user_id
      t.integer :status
      t.integer :type
      t.string :content

      t.timestamps null: false
    end
  end
end
