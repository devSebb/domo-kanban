class RemoveNullConstraintsFromMemberships < ActiveRecord::Migration[7.2]
  def change
    change_column_null :memberships, :organization_id, true
    change_column_null :memberships, :board_id, true
  end
end
