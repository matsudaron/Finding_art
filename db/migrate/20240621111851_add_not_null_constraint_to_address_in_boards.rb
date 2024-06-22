class AddNotNullConstraintToAddressInBoards < ActiveRecord::Migration[7.0]
  def change
    change_column_null :boards, :address, false
  end
end
