# Model for proccesses info
class ServerProcess
  include Mongoid::Document

  field :pid, type: Integer
  field :cpu, type: Float
  field :mem, type: Float
  field :user, type: String
  field :name, type: String
end
