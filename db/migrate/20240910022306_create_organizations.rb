class CreateOrganizations < ActiveRecord::Migration[7.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
