class FavoriteArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :listeners, :playcount, :bio, :url, :mbid, :favorite_albums
end
