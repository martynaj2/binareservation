require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe '#index' do
    subject { get :index }

    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('index') }
    end
  end

  describe '#user_index' do
    subject { get :user_index }

    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('user_index') }
    end
  end

  describe '#show' do
    let(:group) { create(:group) }
    before { get :show, params: { id: group.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('show') }
    end

    context 'group' do
      it { expect(assigns(:group)).to eq(group) }
    end
  end

  describe '#new' do
    before { get :new }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('new') }
    end

    context 'group' do
      it { expect(assigns(:group)).to be_a(Group) }
      it { expect(assigns(:group).persisted?).to eq(false) }
    end
  end

  describe '#edit' do
    let(:group) { create(:group) }
    before { get :edit, params: { id: group.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('edit') }
    end

    context 'group' do
      it { expect(assigns(:group)).to eq(group) }
    end
  end

  describe '#create' do
    let(:valid_attributes) { { group: attributes_for(:group) } }
    let(:invalid_attributes) { { group: attributes_for(:group, title: nil) } }

    context 'valid params' do
      subject { post :create, params: valid_attributes }

      it 'should redirect to group index' do
        expect(subject).to redirect_to(groups_path)
      end

      it 'should redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should create new group' do
        expect { subject }.to change { Group.count }.by(1)
      end
    end

    context 'invalid params' do
      subject { post :create, params: invalid_attributes }

      it 'should render create form' do
        expect(subject).to redirect_to(groups_path)
      end

      it 'should not create new group' do
        expect { subject }.not_to change { Group.count }
      end
    end
  end

  describe '#update' do
    let(:group) { create(:group) }
    let(:valid_attributes) { { id: group.id, group: { title: 'new title' } } }
    let(:invalid_attributes) { { id: group.id, group: { title: nil } } }

    context 'valid params' do
      subject { patch :update, params: valid_attributes }

      it 'should redirect to group index' do
        expect(subject).to redirect_to(groups_path)
      end

      it 'should redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should change group title' do
        subject
        expect(group.reload.title).to eq(group.title)
      end
    end

    context 'invalid params' do
      subject { patch :update, params: invalid_attributes }

      it 'should render edit' do
        expect(subject).to render_template
      end

      it 'should not change title' do
        subject
        expect(group.reload.title).not_to eq('new title')
      end
    end
  end

  describe '#destroy' do
    let(:group) { create(:group) }
    subject { delete :destroy, params: { id: group.id } }

    it 'should redirect to group index' do
      expect(subject).to redirect_to(groups_path)
    end

    it 'should redirect with notice' do
      subject
      expect(flash[:notice]).to be_present
    end

    it 'should destroy group' do
      group_id = group.id
      expect { delete :destroy, params: { id: group_id } }.to change { Group.count }.by(-1)
    end
  end
end
