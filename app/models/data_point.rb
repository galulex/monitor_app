# Model for tracking server info
class DataPoint
  include Mongoid::Document

  field :cpu, type: Float
  field :disk, type: Hash

  belongs_to :instance
  embeds_many :processes, class_name: 'ServerProcess'

  accepts_nested_attributes_for :processes

  validates :cpu, :disk, presence: true
end
