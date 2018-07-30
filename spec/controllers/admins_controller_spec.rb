require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe '#index' do
    let(:veryfied) { { user: attributes_for(:user, veryfied: true) } }
    let(:not_veryfied) { { user: attributes_for(:user,  veryfied: false) } }
    subject { get :index }
    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
      it { expect(response).to redirect_to('') }
    end
  end
end
