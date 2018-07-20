require 'rails_helper'

RSpec.describe UsersController, type: :controller do

   let(:user1) { create(:user, email: 'b@wp.pl') }
   before { sign_in(user1) }

   let(:user2) { create(:user, email: 'c@wp.pl') }
   before { sign_in(user2) }

  describe '#index' do
    subject { get :index }

    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('index') }
    end

    context 'users' do
      
      it 'should return all users' do
        subject
        expect(assigns(:users)).to match_array([user1, user2])
      end
    end

  end
end
