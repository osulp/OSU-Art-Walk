class ChangeIsTemporaryToTemporary < ActiveRecord::Migration
  def change
    change_table :art_pieces do |t|
      t.rename :is_temporary, :temporary
    end
  end
end
