class Api::V1::FavoriteArtistsController < ApplicationController
  include ActionController::Serialization

  def index
    @favoriteArtists = FavoriteArtist.all
    render json: @favoriteArtists
  end

  def create
    @favoriteArtist = FavoriteArtist.find_by(mbid: params['mbid'])

    if @favoriteArtist
      render json: @favoriteArtist
    elsif !@favoriteArtist
      @favoriteArtist = FavoriteArtist.find_or_create_by(
        name: params['name'],
        image: params['image'][3]['#text'],
        listeners: params['stats']['listeners'].to_i,
        playcount: params['stats']['playcount'].to_i,
        bio: params['bio']['content'],
        url: params['url'],
        mbid: params['mbid'],
      )
      render json: {success: @favoriteArtist}
    else
      render json: {favorite_artist_errors: 'Ya dun goofed!'}
    end
  end

  def destroy
    @favoriteArtist = FavoriteArtist.destroy(params[:id])
    @favoriteArtists = FavoriteArtist.all

    render json: @favoriteArtists
  end

end
