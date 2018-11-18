class FavoriteArtist < ApplicationRecord

  has_many :favorite_albums, dependent: :destroy

end
