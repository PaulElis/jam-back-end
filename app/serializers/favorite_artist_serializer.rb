class FavoriteArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :listeners, :playcount, :bio, :url, :mbid, :favorite_albums
  has_many :favorite_albums
end
