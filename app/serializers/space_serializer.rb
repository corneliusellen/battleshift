class SpaceSerializer < ActiveModel::Serializer
  alias :read_attribute_for_serialization :send
  attributes :coordinates, :status, :contents

  def coordinates
    object.coordinates
  end

  def status
    object.status
  end

  def contents
    object.contents
  end
end
