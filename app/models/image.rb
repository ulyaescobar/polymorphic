class Image < ApplicationRecord
  belongs_to :imgeable, polymorphic: true
  mount_uploader :image, ImageUploader
  before_save :add_metadata_to_image, if: :new_record?
  attr_accessor :user_email

  def add_metadata_to_image

    return unless image.present? && image.file.present?
    Rails.logger.info("User Email in add_metadata_to_image: #{user_email}")
    
  
      file_path = image.path 
      exif = MiniExiftool.new(file_path)
      if exif['Creator'].present?
        if exif['Creator'] == user_email
          return
        elsif exif['Contributor'] != user_email
          exif['Contributor'] = user_email
        end
      else
        exif['Creator'] = user_email
      end
      exif.save!


  end

  def new_attribute
    {
      id: self.id,
      image: self.image,
      imageable_type: self.imgeable_type,
      imageable_id: self.imgeable_id
    }
  end
end
