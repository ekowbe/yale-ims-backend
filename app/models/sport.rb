class Sport < ApplicationRecord
    has_many :teams
    has_many :players, through: :teams
    has_many :matches, through: :teams
    has_many_attached :images

    def format_images
        object.images.map{|img| img.variant(resize_to_limit: [500, 500])}
    end
end
