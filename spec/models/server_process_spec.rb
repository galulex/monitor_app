require 'rails_helper'

RSpec.describe ServerProcess, type: :model do
  context 'fields' do
    it { is_expected.to have_fields(:pid, :user, :name, :cpu, :mem) }
  end
end
