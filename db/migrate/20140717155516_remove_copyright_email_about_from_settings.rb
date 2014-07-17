class RemoveCopyrightEmailAboutFromSettings < ActiveRecord::Migration
  def change
    remove_column :settings, :copyright, :text
    remove_column :settings, :email, :string
    remove_column :settings, :about, :text
  end
end
