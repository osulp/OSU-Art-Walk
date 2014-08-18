class CreateTableSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :name
    end
  end
end
