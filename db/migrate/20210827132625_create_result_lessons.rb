class CreateResultLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :result_lessons do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
