class AddAddressToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :address, :text
  end
end
