class SportSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :teams
end
