#
class CreateKarmaQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :karma_questions do |t|
      t.string :karma_question, null: false
      t.integer :question_like, default: 0
      t.references :developer, index: true, foreign_key: true

      t.timestamps
    end
  end
end
