class AddNameValueToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :setting_name, :string
    add_column :settings, :value, :text
  end
end
