class ImagesController < ApplicationController
    before_action :authenticate_request

    def index
        images = Image.all
        render json: {
            status: 200,
            data: {
                image: images
            }
        }, status: :ok
    end

    def create
        project = Project.find_by(id: image_params[:project_id])
        if project.nil?
          render json: { status: 422, message: "Project not found" }, status: :unprocessable_entity
          return
        end

        image = Image.create(image_params)
        if image.save
            render json: {
                status: 201,
                data: {
                    image: image
                }
            }, status: :created
        else
            render json:{
                status: 422,
                messages: image.errors.full_messages
            }, status: :unprocessable_entity
        end
    end

    private

    def image_params
        params.permit({image: []}, :project_id)
    end
end
