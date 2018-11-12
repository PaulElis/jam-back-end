class Api::V1::FavoriteAlbumsController < ApplicationController

  def index
    @favoriteAlbums = FavoriteAlbum.all
    render json: @favoriteAlbums
  end

  def create
    # @artist = FavoriteArtist.create
    # @artist = FavoriteArtist.find_or_create_by(
    #   mbid: params['artist']['mbid']
    # )
    @favoriteArtist = FavoriteArtist.find_by(mbid: params['artist']['mbid'])
    if @favoriteArtist
      render json: @favoriteArtist
    elsif !@favoriteArtist
      @favoriteArtist = FavoriteArtist.find_or_create_by(
        name: params['artist']['name'],
        image: params['artist']['image'][3]['#text'],
        listeners: params['artist']['stats']['listeners'].to_i,
        playcount: params['artist']['stats']['playcount'].to_i,
        bio: params['artist']['bio']['content'],
        url: params['artist']['url'],
        mbid: params['artist']['mbid'],
      )
      render json: {success: @favoriteArtist}
    else
      render json: {favorite_artist_errors: 'Ya dun goofed!'}
    end

    @favoriteAlbum = FavoriteAlbum.find_or_create_by(
      name: params['name'],
      image: params['image'][3]['#text'],
      playcount: params['playcount'],
      url: params['url'],
      favorite_artist_id: @favoriteArtist.id,
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
