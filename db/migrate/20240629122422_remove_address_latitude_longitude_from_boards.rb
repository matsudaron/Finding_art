class RemoveAddressLatitudeLongitudeFromBoards < ActiveRecord::Migration[7.0]
  def change
    remove_column :boards, :address, :text
    remove_column :boards, :latitude, :float
    remove_column :boards, :longitude, :float
  end
end
