require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }
  before { sign_in(user) }

  describe '#index' do
    it 'should return successful response' do
        get :index
        expect(response).to be_successful
    end
  end

  it 'should render index template' do
    get :index
    expect(response).to render_template('index')
  end

end
