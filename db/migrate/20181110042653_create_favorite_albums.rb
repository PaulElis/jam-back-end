class CreateFavoriteAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_albums do |t|
      t.string :name
      t.integer :playcount
      t.string :image
      t.string :url
      t.integer :favorite_artist_id
    end
  end
end
