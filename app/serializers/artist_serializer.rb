class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :listeners, :playcount, :bio, :url, :mbid, :albums
end
