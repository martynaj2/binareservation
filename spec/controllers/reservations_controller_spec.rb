require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe '#index' do
    subject { get :index }

    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('index') }
    end

    context 'reservation' do
      let!(:reservation1) { create(:reservation) }

      it 'should return all reservations' do
        subject
        expect(assigns(:reservations)).to match_array([reservation1])
      end
    end
  end

  describe '#show' do
    let(:reservation) { create(:reservation) }
    before { get :show, params: { id: reservation.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('show') }
    end

    context 'reservation' do
      it { expect(assigns(:reservation)).to eq(reservation) }
    end
  end

  describe '#new' do
    before { get :new }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('new') }
    end

    context 'reservation' do
      it { expect(assigns(:reservation)).to be_a(Reservation) }
      it { expect(assigns(:reservation).persisted?).to eq(false) }
    end
  end

  describe '#edit' do
    let(:reservation) { create(:reservation) }
    before { get :edit, params: { id: reservation.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('edit') }
    end

    context 'reservation' do
      it { expect(assigns(:reservation)).to eq(reservation) }
    end
  end

  describe '#destroy' do
    let(:reservation) { create(:reservation) }
    subject { delete :destroy, params: { id: reservation.id } }

    it 'should redirect to reservations index' do
      expect(subject).to redirect_to(reservations_path)
    end

    it 'should redirect with notice' do
      subject
      expect(flash[:notice]).to be_present
    end

    it 'should destroy reservation' do
      reservation_id = reservation.id
      expect { delete :destroy, params: { id: reservation_id } }.to change { Reservation.count }.by(-1)
    end
  end
end
