require 'rails_helper'

RSpec.describe Instance, type: :model do
  context 'associations' do
    it { is_expected.to have_many :datapoints }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_uniqueness_of(:url) }

    it do
      is_expected.to validate_format_of(:url)
        .to_allow('http://lvh.me')
        .not_to_allow('url')
    end
  end

  context 'fields' do
    it { is_expected.to have_fields(:name, :url, :token) }
  end
end
