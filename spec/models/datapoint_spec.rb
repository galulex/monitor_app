require 'rails_helper'

RSpec.describe DataPoint, type: :model do
  context 'associations' do
    it { is_expected.to belong_to :instance }
    it { is_expected.to embed_many :processes }
    it { is_expected.to accept_nested_attributes_for(:processes) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:cpu) }
    it { is_expected.to validate_presence_of(:disk) }
  end

  context 'fields' do
    it { is_expected.to have_fields(:cpu, :disk) }
  end
end
