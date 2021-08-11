class CreateSummaries < ActiveRecord::Migration[6.1]
  def change
    create_table :summaries do |t|
      t.text :content
      t.boolean :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
