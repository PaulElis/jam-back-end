class Api::V1::FavoriteAlbumsController < ApplicationController

  def index
    @favoriteAlbums = FavoriteAlbum.all
    render json: @favoriteAlbums
  end

  def create
    @artist = FavoriteArtist.find_or_create_by(
      mbid: params['artist']['mbid']
    )

    @favoriteAlbum = FavoriteAlbum.find_or_create_by(
      name: params['name'],
      image: params['image'][3]['#text'],
      playcount: params['playcount'],
      url: params['url'],
      favorite_artist_id: @artist.id,
    )

    if @favoriteAlbum.save
      render json: @favoriteAlbum
    else
      render json: {favorite_album_errors: 'Ya dun goofed!'}
      @favoriteAlbum.errors.messages
    end
  end

  def destroy
    @favoriteAlbum = FavoriteAlbum.destroy(params[:id])
    @favoriteAlbums = FavoriteAlbum.all
      render json:
        { success: "#{@favoriteAlbum[:name]} Destroyed!",
          favorites: @favoriteAlbums }
  end

end
