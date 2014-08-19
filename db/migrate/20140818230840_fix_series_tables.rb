class FixSeriesTables < ActiveRecord::Migration
  def change
      remove_column :art_pieces, :series_id, :integer
      remove_column :series, :artpieces_id, :integer
  end
end
