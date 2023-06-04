class Project < ApplicationRecord
    belongs_to :user
    has_many :images, dependent: :destroy
    belongs_to :retweeted_project, class_name: 'Project', optional: true
    
    accepts_nested_attributes_for :images, allow_destroy: true


    validates :caption, presence: true
    # validate :at_least_one_image
    # validates :images, presence: { message: "At least one image is required" }

    def retweeted_project_attributes
        if retweeted_project
          {
            id: retweeted_project.id,
            caption: retweeted_project.caption,
            user_id: retweeted_project.user_id,
            images: retweeted_project.images.map(&:new_attribute)
          }
        else
          {}
        end
    end
    
    def new_attribute 
        {
          id: self.id,
          caption: self.caption,
          user_id: self.user_id,
          images: self.images.map(&:new_attribute),
          # retweeted_project: retweeted_project_attributes
        }
    end

    private

end
