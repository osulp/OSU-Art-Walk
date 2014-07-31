class ChangeTypeToMediumInMedia < ActiveRecord::Migration
  def change
    change_table :media do |t|
      t.rename :type, :medium
    end
  end
end
