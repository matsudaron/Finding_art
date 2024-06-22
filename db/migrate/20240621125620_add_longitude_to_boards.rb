class AddLongitudeToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :longitude, :float
  end
end
