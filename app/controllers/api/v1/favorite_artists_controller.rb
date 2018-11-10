class Api::V1::FavoriteArtistsController < ApplicationController

  def index
    @favoriteArtists = FavoriteArtist.all
    render json: @favoriteArtists
  end

  def create
    @favoriteArtist = FavoriteArtist.find_or_create_by(
      name: params['name'],
      image: params['image'][3]['#text'],
      listeners: params['listeners'],
      playcount: params['playcount'],
      url: params['url'],
      mbid: params['mbid'],
    )
    if @favoriteArtist.save
      render json: @favoriteArtist
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
