class FilesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @files = current_user.uploaded_files.order("name DESC").page params[:page]
  end

  def new
    @file = UploadedFile.new(name: "New file")
    render :show
  end

  def show
    @file = UploadedFile.find(params[:id])
    authorize! :show, @file
  end

  def create
    @file = UploadedFile.new(post_params)
    authorize! :create, @file

    @file.user = current_user

    if @file.save
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def update
    @file = UploadedFile.find(params[:id])
    authorize! :update, @file

    @file.update_attributes(put_params)
    render :show
  end

  def destroy
    @file = UploadedFile.find(params[:id])
    authorize! :destroy, @file

    @file.destroy
    redirect_to :action => :index
  end


  private

  def put_params
    params[:uploaded_file].slice(:name, :description)
  end

  def post_params
    params[:uploaded_file].slice(:name, :description, :file)
  end
end
