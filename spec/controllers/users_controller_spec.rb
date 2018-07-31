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

  describe '#update' do
    let(:user) {create(:user)}
    before { sign_in(user) }
    let(:valid_attributes) { { id: user.id, user: { name: 'Name', surname: 'Surname' } } }
    let(:invalid_attributes) { { id: user.id, user: { name: nil, surname: nil } } }

    context 'valid params' do
      subject { patch :update, params: valid_attributes }

      it 'should redirect to user index' do
        expect(subject).to redirect_to(profile_path)
      end

      it 'should redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should change user Name and Surname' do
        subject
        expect(user.reload.name).to eq( 'Name' )
        expect(user.reload.surname).to eq( 'Surname' )
      end
    end

    context 'invalid params' do
      subject { patch :update, params: invalid_attributes }

      it 'should render edit' do
        expect(subject).to render_template('edit')
      end

      it 'should not change title' do
        subject
        expect(user.reload.name).not_to eq('Name')
        expect(user.reload.surname).not_to eq( 'Surname' )
      end
    end
  end

  describe '#vacation' do
    let(:user) {create(:user)}
    before { sign_in(user) }
    before { put :vacation, params: { id: user.id } }

    context 'valid params' do

      it 'should redirect to user index' do
        expect(subject).to redirect_to(profile_path)
      end

      it 'should change user vacation status' do
        subject
        expect(user.reload.vacation).to eq( true )
      end
    end
  end
end
