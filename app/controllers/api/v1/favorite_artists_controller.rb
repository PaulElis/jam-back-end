class Api::V1::FavoriteArtistsController < ApplicationController
  include ActionController::Serialization

  def index
    @favoriteArtists = FavoriteArtist.all
    render json: @favoriteArtists
  end

  def create
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
  end

  def destroy
    @favoriteArtist = FavoriteArtist.destroy(params[:id])
    # @deletedAlbums = FavoriteAlbum.destroy(params[:id])

    @favoriteArtists = FavoriteArtist.all
    @favoriteAlbums = FavoriteArtist.all.map{ |artist| artist.favorite_albums.map { |album| album }}

    render json: { favorite_artists: @favoriteArtists }
      # render json:
      #   { success: "#{@favoriteArtist[:name]} Destroyed!",
      #     favorite_artists: @favoriteArtists,
      #     favorite_albums: @favoriteAlbums
      #   }
  end

end
