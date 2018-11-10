class CreateFavoriteArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_artists do |t|
      t.string :name
      t.string :image
      t.integer :listeners
      t.integer :playcount
      t.string :bio
      t.string :url
      t.string :mbid
    end
  end
end
