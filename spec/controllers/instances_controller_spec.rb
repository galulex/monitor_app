require 'rails_helper'

RSpec.describe InstancesController, type: :controller do
  let(:instance) { build_stubbed(:instance) }
  let(:instance_attrs) { attributes_for(:instance) }

  before do
    allow(Net::HTTP).to receive(:get_response).and_return(double(code: '200'))
  end

  describe 'GET #index' do
    before { get :index }

    it 'renders index' do
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      subject { xhr :post, :create, instance: instance_attrs.merge(url: '') }

      it 'renders new' do
        expect(subject).to render_template(:new)
      end
    end

    context 'with valid params' do
      subject { xhr :post, :create, instance: instance_attrs }

      it 'creates the instance' do
        expect { subject }.to change(Instance, :count).by(1)
      end

      it 'is success' do
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { xhr :delete, :destroy, id: instance }

    before do
      allow_any_instance_of(described_class).to receive(:instance).and_return(instance)
    end

    it 'destroys instance' do
      expect(instance).to receive(:destroy)
      expect(subject).to be_successful
    end
  end
end
