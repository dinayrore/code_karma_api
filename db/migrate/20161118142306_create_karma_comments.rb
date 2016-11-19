#
class CreateKarmaComments < ActiveRecord::Migration[5.0]
  def change
    create_table :karma_comments do |t|
      t.string :karma_comment, null: false
      t.integer :comment_like, default: 0
      t.references :karma_question, index: true, foreign_key: true
      t.references :developer, index: true, foreign_key: true

      t.timestamps
    end
  end
end
