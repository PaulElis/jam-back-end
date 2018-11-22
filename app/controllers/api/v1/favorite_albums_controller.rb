class Api::V1::FavoriteAlbumsController < ApplicationController
  include ActionController::Serialization

  def index
    @favoriteAlbums = FavoriteAlbum.all
    render json: @favoriteAlbums
  end

  def create
    @favoriteArtist = FavoriteArtist.find_by(mbid: params['artist']['mbid'])

    if !@favoriteArtist
      FavoriteArtist.create
    end

    @favoriteAlbum = FavoriteAlbum.find_or_create_by(
      name: params['name'],
      image: params['image'][3]['#text'],
      playcount: params['playcount'],
      url: params['url'],
      favorite_artist_id: @favoriteArtist.id )
    if @favoriteAlbum.save
      render json: @favoriteAlbum
    else
      render json: {favorite_album_errors: 'Ya dun goofed!'}
      @favoriteAlbum.errors.messages
    end
  end

  def destroy
    @favoriteAlbum = FavoriteAlbum.destroy(params[:id])
    @favoriteArtists = FavoriteArtist.all
    
    render json: @favoriteArtists
  end

end
