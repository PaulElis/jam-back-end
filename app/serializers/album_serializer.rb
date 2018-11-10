class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :playcount, :image, :url, :artist_id, :artist
  def artist
    {id: self.object.artist.id, 
     name: self.object.artist.name}
  end
end
