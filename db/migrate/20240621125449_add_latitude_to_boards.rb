class AddLatitudeToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :latitude, :float
  end
end
