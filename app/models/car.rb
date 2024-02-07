class Car < ApplicationRecord
  has_many_attached :images

  validate :validate_image_types

  def image_urls
    images.map { |image| Rails.application.routes.url_helpers.rails_blob_url(image.blob, only_path: true) } if images.attached?
  end

  private

  def validate_image_types
    if images.attached?
      images.each do |image|
        if !image.content_type.in?(%w[image/jpeg image/png])
          errors.add(:images, 'must be a JPEG or PNG file')
        end
      end
    end
  end
end
