class FillAddressInBoardsWithDefaultValue < ActiveRecord::Migration[7.0]
  def up
    # 既存のNULL値をデフォルト値（例えば空文字列）で埋める
    Board.where(address: nil).update_all(address: "")
  end

  def down
    # 逆マイグレーションは何もしない
  end
end
