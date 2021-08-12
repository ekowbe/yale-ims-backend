class CollegeSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, :name, :shield

  def shield
    rails_blob_path(object.shield, only_path: true) if object.shield.attached?
  end

  
end
