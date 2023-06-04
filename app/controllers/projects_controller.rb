class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    @projects = current_user.projects
    render json: @projects.map(&:new_attribute)
  end

  # POST /projects
  # def create
  #   @project = current_user.projects.new(project_params)

  #   if @project.save
  #     render json: @project.new_attribute
  #   else
  #     render json: @project.errors, status: :unprocessable_entity
  #   end
  # end

  def create
    # # Create a new project with retweet
    # if params[:retweeted_project_id]
    #   retweeted_project = Project.find_by(id: params[:retweeted_project_id])
    #   @project = current_user.projects.build(retweeted_project.attributes.except("id", "created_at", "updated_at"))
    #   @project.retweeted_project_id = params[:retweeted_project_id]
    # else
    #   # Create a regular project
    #   @project = current_user.projects.build(project_params)
    # end

    @project = current_user.projects.new(project_params)

    if params[:retweeted_project_id].present?
      retweeted_project = Project.find_by(id: params[:retweeted_project_id])
      @project.retweeted_project = retweeted_project
      @project.images = retweeted_project.images.map(&:dup)
    end

    if @project.save
      render json: @project.new_attribute, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # def create
  #   project = current_user.projects.build(project_params)

  #   ActiveRecord::Base.transaction do
  #     if project.save
  #       params[:images]&.each do |image|
  #         project.images.create(image: image)
  #       end

  #       render json: { project: project.new_attribute }, status: :created
  #     else
  #       render json: { errors: project.errors }, status: :unprocessable_entity
  #     end
  #   end
  # end

  # def create
  #   ActiveRecord::Base.transaction do
  #     project = current_user.projects.build(project_params)
      
  #     if project.save
  #       create_images(project)
  #       render json: project.new_attribute, status: :created
  #     else
  #       render json: { errors: project.errors }, status: :unprocessable_entity
  #     end
  #   end
  # end

  # def create
  #   ActiveRecord::Base.transaction do
  #     project = current_user.projects.build(project_params)
      
  #     if project.save
  #       unless create_images(project)
  #         render json: { errors: project.errors }, status: :unprocessable_entity
  #         return
  #       end
        
  #       render json: project.new_attribute, status: :created
  #     else
  #       render json: { errors: project.errors }, status: :unprocessable_entity
  #     end
  #   end
  # end

  def update
    if @project.update(project_params)
      render json: @project.new_attribute
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @project.destroy
    render json: {
      status: 200,
      message: "deleted"
    }, status: :ok
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = current_user.projects.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.permit(:caption, :retweeted_project_id, images_attributes: [:id, :image, :_destroy])
  end

  # def project_params
  #   params.permit(:caption)
  # end

  # def create_images(project)
  #   image_params = params[:images]
    
  #   return if image_params.blank?
    
  #   image_params.each do |image_data|
  #     project.images.create(image: image_data)
  #   end
  # end

  def create_images(project)
    image_params = params[:images]
  
    images = image_params&.reject(&:blank?)
    if images.blank?
      project.errors.add(:base, "At least one image is required")
      return false
    end
  
    images.each do |image_data|
      project.images.build(image: image_data)
    end
    # params[:images]&.each do |image|
      #         project.images.create(image: image)
      #       end
  
    project.save
  end


  def update_images(project)
    image_params = params[:images]

    return if image_params.blank?

    # Delete existing images that are not included in the updated image_params
    project.images.where.not(id: image_params.pluck(:id)).destroy_all

    image_params.each do |image_data|
      if image_data[:id].present?
        image = project.images.find(image_data[:id])
        image.update(image: image_data[:image]) if image.present?
      else
        project.images.create(image: image_data[:image])
      end
    end
  end

end