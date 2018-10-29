class Api::V1::ArtistsController < ApplicationController

  def index
    @artists = Artist.all
    render json: @artists
  end

  def create
    @artist = Artist.find_or_create_by(
      name: params['name'],
      image: params['image'][3]['#text'],
      listeners: params['listeners'],
      playcount: params['playcount'],
      url: params['url'],
      mbid: params['mbid'],
    )
    if @artist.save
      render json: @artist
    else
      render json: {errors: 'Ya dun goofed!'}
    end
  end

  def destroy
    @artist = Artist.destroy(params[:id])
    @artists = Artist.all
      render json:
        { success: "#{@artist[:name]} Destroyed!",
          favorites: @artists }
  end

end
