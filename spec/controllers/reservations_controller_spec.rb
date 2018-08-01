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
      let!(:reservation2) { create(:reservation, start_date: reservation1.start_date + 24.hours, end_date: reservation1.end_date + 24.hours) }

      it 'should return all reservations' do
        subject
        expect(assigns(:reservations)).to match_array([reservation1, reservation2])
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

  # describe '#create' do
  #   let(:valid_attributes) { { reservation: attributes_for(:reservation) } }
  #   let(:invalid_attributes) { { reservation: attributes_for(:reservation, title: nil) } }
  #
  #   context 'valid params' do
  #     subject { post :create, params: valid_attributes }
  #
  #     it 'should redirect to reservation index' do
  #       expect(subject).to redirect_to(reservations_path)
  #     end
  #
  #     it 'should redirect with notice' do
  #       subject
  #       expect(flash[:notice]).to be_present
  #     end
  #
  #     it 'should create new reservation' do
  #       expect{subject}.to change{ Reservation.count }.by(1)
  #     end
  #   end
  #
  #   context 'invalid params' do
  #     subject { post :create, params: invalid_attributes }
  #
  #     it 'should render reservation list' do
  #       expect(subject).to redirect_to(reservations_path)
  #     end
  #
  #     it 'should not create new reservation' do
  #       expect{ subject }.to change{ Reservation.count }
  #     end
  #   end
  # end
  #
  # describe '#update' do
  #   let(:reservation) {create(:reservation)}
  #   let(:valid_attributes) { { id: reservation.id, reservation: { title: 'title' } } }
  #   let(:invalid_attributes) { { id: reservation.id, reservation: { title: nil } } }
  #
  #   context 'valid params' do
  #     subject { patch :update, params: valid_attributes }
  #
  #     it 'should redirect to reservations index' do
  #       expect(subject).to redirect_to(reservations_path)
  #     end
  #
  #     it 'should redirect with notice' do
  #       expect(flash[:notice]).to be_present
  #     end
  #
  #     it 'should change reservation title' do
  #       subject
  #       expect(reservation.reload.title).to eq( 'title' )
  #     end
  #   end
  #
  #   context 'invalid params' do
  #     subject { patch :update, params: invalid_attributes }
  #
  #     it 'should render edit' do
  #       expect(subject).to redirect_to(reservations_path)
  #     end
  #
  #     it 'should not change title' do
  #       subject
  #       expect(reservation.reload.title).not_to eq('new title')
  #     end
  #   end
  # end

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
