class CreateMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :organization, foreign_key: true
      t.references :board, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
