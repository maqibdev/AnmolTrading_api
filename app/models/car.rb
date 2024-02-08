class Car < ApplicationRecord
  has_many_attached :images

  validate :validate_image_types

  def image_urls
    return unless images.attached?

    images.map do |image|
      Rails.application.routes.url_helpers.rails_blob_url(image.blob, only_path: true)
    end
  end

  private

  def validate_image_types
    return unless images.attached?

    images.each do |image|
      errors.add(:images, 'must be a JPEG or PNG file') unless image.content_type.in?(%w[image/jpeg image/png])
    end
  end
end
