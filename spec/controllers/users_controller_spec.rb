require 'rails_helper'

RSpec.describe UsersController, type: :controller do

   let(:user1) { create(:user) }
   before { sign_in(user1) }

   let(:user2) { create(:user) }
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

  describe '#show' do
    before { get :show, params: { id: user1.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('show') }
    end

    context 'user' do
      it { expect(assigns(:user)).to eq(user1) }
    end
  end

  describe '#edit' do
    before { get :edit, params: { id: user2.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('edit') }
    end

    context 'user' do
      it { expect(assigns(:user)).to eq(user2) }
    end
  end

  
end
