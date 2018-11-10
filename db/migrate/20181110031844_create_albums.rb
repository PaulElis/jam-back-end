class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :playcount
      t.string :image
      t.string :url
      t.integer :artist_id
    end
  end
end
