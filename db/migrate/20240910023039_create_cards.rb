class CreateCards < ActiveRecord::Migration[7.2]
  def change
    create_table :cards do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.integer :position
      t.references :list, null: false, foreign_key: true
      t.boolean :archived
      t.references :assigned_user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
