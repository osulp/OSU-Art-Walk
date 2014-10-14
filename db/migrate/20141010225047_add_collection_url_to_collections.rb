class AddCollectionUrlToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :collection_url, :string
  end
end
