class Api::V1::FavoriteArtistsController < ApplicationController

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
      render json: {errors: 'Ya dun goofed!'}
    end
  end

  def destroy
    @favoriteArtist = FavoriteArtist.destroy(params[:id])
    @favoriteArtists = FavoriteArtist.all
      render json:
        { success: "#{@favoriteArtist[:name]} Destroyed!",
          favorites: @favoriteArtists }
  end

end
