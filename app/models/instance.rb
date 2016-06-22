# Main model to keep server information
class Instance
  include Mongoid::Document

  field :name, type: String
  field :url, type: String
  field :token, type: String

  has_many :datapoints, class_name: 'DataPoint', dependent: :delete
  has_one :datapoint, class_name: 'DataPoint'

  validates :name, :url, :token, presence: true
  validates :name, :url, uniqueness: true
  validates :url, format: { with: %r(https?:\/\/[\S]+) }

  validate :agent, on: :create

  private

  def agent
    return unless errors.blank?
    Timeout.timeout(3) do
      uri = URI.parse("#{url}:9292/verify?token=#{token}")
      res = Net::HTTP.get_response(uri)
      return if res.code == '200'
      errors.add(:url, 'No agent running for this url or invalid token')
    end
  rescue
    errors.add(:url, 'No agent running for this url or invalid token')
  end
end
