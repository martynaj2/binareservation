require 'rails_helper'

RSpec.describe HallsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe '#index' do
    subject { get :index }

    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('index') }
    end

    context 'halls' do
      let!(:hall_1) { create(:hall) }
      let!(:hall_2) { create(:hall) }

      it 'should return all halls' do
        subject
        expect(assigns(:halls)).to match_array( [hall_1, hall_2] )
      end
    end
  end

  describe '#show' do
    let(:hall) { create(:hall) }
    before { get :show, params: { id: hall.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('show') }
    end

    context 'hall' do
      it { expect(assigns(:hall)).to eq(hall) }
    end
  end

  describe '#new' do
    before { get :new }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('new') }
    end

    context 'hall' do
      it { expect(assigns(:hall)).to be_a(Hall) }
      it { expect(assigns(:hall).persisted?).to eq(false) }
    end
  end

  describe '#edit' do
    let(:hall) { create(:hall) }
    before { get :edit, params: { id: hall.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('edit') }
    end

    context 'hall' do
      it { expect(assigns(:hall)).to eq(hall) }
    end
  end

  describe '#create' do
    let(:valid_attributes) { { hall: attributes_for(:hall) } }
    let(:invalid_attributes) { { hall: attributes_for(:hall, name: nil) } }

    context 'valid params' do
      subject { post :create, params: valid_attributes }

      it 'should redirect to halls index' do
        expect(subject).to redirect_to(halls_path)
      end

      it 'should redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should create new hall' do
        expect{subject}.to change{ Hall.count }.by(1)
      end
    end

    context 'invalid params' do
      subject { post :create, params: invalid_attributes }

      it 'should render room list' do
        expect(subject).to redirect_to(halls_path)
      end

      it 'should not create new hall' do
        expect{ subject }.to change{ Hall.count }
      end
    end
  end

  describe '#update' do
    let(:hall) {create(:hall)}
    let!(:valid_attributes) { { id: hall.id, hall: { title: 'new title' } } }
    let(:invalid_attributes) { { id: hall.id, hall: { title: nil } } }

    context 'valid params' do
      subject { patch :update, params: valid_attributes }

      it 'should redirect to halls index' do
        expect(subject).to redirect_to(halls_path)
      end

      it 'should redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      # it 'should change hall title' do
      #   expect(hall.reload.title).to eq('new title')
      # end
    end

    context 'invalid params' do
      subject { patch :update, params: invalid_attributes }

      it 'should render edit' do
        expect(subject).to render_template('edit')
      end

      it 'should not change title' do
        subject
        expect(hall.reload.title).not_to eq('new title')
      end
    end
  end

  describe '#destroy' do
    let(:hall) { create(:hall) }
    subject {delete :destroy, params: { id: hall.id }}

    it 'should redirect to halls index' do
      expect(subject).to redirect_to(halls_path)
    end

    it 'should not redirect with notice' do
      subject
      expect(flash[:notice]).not_to be_present
    end

    it 'should destroy hall' do
      hall_id = hall.id
      expect{ delete :destroy, params: { id: hall_id } }.to change{ Hall.count }.by(-1)
    end
  end
end
