class MatchSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_completed, :date_time
end
