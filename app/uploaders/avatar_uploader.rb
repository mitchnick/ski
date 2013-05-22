# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  if Rails.env.production?
    # set where we store in production
    storage :file     # Store locally for testing
  else 
    storage :file     # Store locally for testing
  end

  # Restrict uploads to images only
  def extension_white_list
    %w(jpg jpeg)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename 
    "#{model.name}.#{file.extension}" if original_filename
  end

  process :resize_to_fill => [200,200]

end
