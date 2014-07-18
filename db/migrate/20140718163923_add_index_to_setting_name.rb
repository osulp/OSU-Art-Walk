class AddIndexToSettingName < ActiveRecord::Migration
  def change
    add_index :settings, :setting_name
  end
end
