require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:user) { create(:user, admin: true) }
  before { sign_in(user) }

  describe '#index' do
    subject { get :index }
    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }
    subject { delete :destroy, params: { id: user.id } }

    it 'should redirect with notice' do
      subject
      expect(flash[:notice]).not_to be_present
    end

    it 'should destroy user' do
      expect{
        delete :destroy, params: {id: user.id}
      }.to change{ User.count }.by(0)
    end
  end

  describe '#verify' do
    let(:user) { create(:user, verified: false) }

    describe 'should response' do
      it { expect(response).to be_successful }
    end

    context 'user' do
      it { expect(assigns(:user)).not_to eq(user) }
    end
  end
end
