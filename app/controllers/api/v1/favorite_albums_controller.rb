class Api::V1::FavoriteAlbumsController < ApplicationController

  def index
    @favoriteAlbums = FavoriteAlbum.all
    render json: @favoriteAlbums
  end

  def create
    @artist = Artist.find_or_create_by(
      mbid: params['artist']['mbid']
    )

    @favoriteAlbum = FavoriteAlbum.find_or_create_by(
      name: params['name'],
      image: params['image'][3]['#text'],
      playcount: params['playcount'],
      url: params['url'],
      favorite_artist_id: @artist.id,
    )
    byebug
    if @favoriteAlbum.save
      render json: @favoriteAlbum
    else
      render json: {errors: 'Ya dun goofed!'}
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
