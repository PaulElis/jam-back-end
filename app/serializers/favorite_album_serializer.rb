class FavoriteAlbumSerializer < ActiveModel::Serializer
  belongs_to :favorite_artist
  attributes :id, :name, :playcount, :image, :url, :favorite_artist_id, :favorite_artist

  def favorite_artist
    {id: self.object.favorite_artist.id,
     name: self.object.favorite_artist.name}
  end
end
