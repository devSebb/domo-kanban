class CreateBoards < ActiveRecord::Migration[7.2]
  def change
    create_table :boards do |t|
      t.string :name
      t.text :description
      t.string :visibility
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
