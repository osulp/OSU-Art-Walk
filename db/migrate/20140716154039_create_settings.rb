class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.text :copyright
      t.string :email
      t.text :about

      t.timestamps
    end
  end
end
