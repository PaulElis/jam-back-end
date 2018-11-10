class FavoriteAlbum < ApplicationRecord

  belongs_to :favorite_artist, :foreign_key => 'favorite_artist_id'

end
