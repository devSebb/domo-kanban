class RemoveNullFalseFromCards < ActiveRecord::Migration[7.2]
  def change
    change_column_null :cards, :assigned_user_id, true
  end
end
