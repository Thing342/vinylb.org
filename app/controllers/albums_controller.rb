class AlbumsController < ApplicationController
  before_action :set_user, only: [:index, :show, :new, :edit, :create, :update, :destroy, :search]
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:index, :show, :new, :edit, :create, :update, :destroy, :search]

  # GET /albums
  # GET /albums.json
  def index
    @albums = @user.albums
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  def search
    @query = params[:search].to_s.downcase.strip
    @albums = []
    @user.albums.find_each do |model|
      if model.title.downcase.include? @query or model.artist.downcase.include? @query or model.year.to_s.downcase.include? @query
        @albums.append model
      end
    end

    render 'index'
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = @user.albums.create(album_params)
    if @album.save
      flash[:success] = "Album successfully created!"
      redirect_to albums_path(@user)
    else
      flash[:danger] = "Unable to create albums."
      redirect_to new_album_url
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    @album.image = nil
    if @album.update_attributes(album_params)
      flash[:success] = "Album successfully saved."
      redirect_to albums_path(@user)
    else
      flash[:danger] = "Unable to save album."
      redirect_to edit_album_url
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:uid])
  end

  def set_album
    @album = Album.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def album_params
    params.require(:album).permit(:user, :title, :year, :artist)
  end

  def correct_user
    puts(action_name, current_user.id, @user.id)
    redirect_to(home_loc) unless current_user? @user
  end

end

