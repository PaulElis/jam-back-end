class Api::V1::AlbumsController < ApplicationController

  def index
    @albums = Album.all
    render json: @albums
  end

  def create
    @artist = Artist.find_or_create_by(
      mbid: params['artist']['mbid']
    )

    @album = Album.find_or_create_by(
      name: params['name'],
      image: params['image'][3]['#text'],
      playcount: params['playcount'],
      url: params['url'],
      artist_id: @artist.id,
    )
    if @album.save
      render json: @album
    else
      render json: {errors: 'Ya dun goofed!'}
    end
  end

  def destroy
    @album = Album.destroy(params[:id])
    @albums = Album.all
      render json:
        { success: "#{@album[:name]} Destroyed!",
          favorites: @albums }
  end

end
