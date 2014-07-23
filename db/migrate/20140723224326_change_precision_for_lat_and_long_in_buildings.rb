class ChangePrecisionForLatAndLongInBuildings < ActiveRecord::Migration
  def up
    change_column :buildings, :lat, :decimal, :precision => 10, :scale => 6
    change_column :buildings, :long, :decimal, :precision => 10, :scale => 6
  end

  def down
    change_column :buildings, :lat, :float
    change_column :buildings, :long, :float
  end
end
