# frozen_string_literal: true

require 'rails_helper'

describe 'API::V1::Users', type: :controller do
  let(:signedin_user) {
    user = User.create!(email: 'qwe@qwe.com', password: 'qwe', time_zone: 1)
    user.authenticate('qwe')
    user
  }

  let(:token) {
    signedin_user.token
  }

  context '#index' do
    it 'fails for anonymouse user' do
      get '/api/v1/users'
      expect(response).to have_http_status 401
    end

    it 'works for legal user' do
      user = User.create!(email: 'qwe1@qwe.com', password: 'qwe', time_zone: 1)

      get '/api/v1/users', params: { token: token }

      expect(response).to have_http_status 200
      expect(json_response.map { |user| user[:id] }).to match_array [user.id, signedin_user.id]
    end
  end

  context '#login' do
    context 'fails' do
      it 'on incorrect email' do
        user = User.create!(email: 'qwe@qwe.com', password: 'qwe', time_zone: 1)

        post '/api/v1/users', params: { email: 'qwe2@qwe.com', password: 'qwe' }

        expect(response).to have_http_status 401
      end

      it 'on incorrect password' do
        user = User.create!(email: 'qwe@qwe.com', password: 'qwe', time_zone: 1)

        post '/api/v1/users', params: { email: 'qwe@qwe.com', password: '123' }

        expect(response).to have_http_status 401
      end
    end

    it 'works' do
      user = User.create!(email: 'qwe@qwe.com', password: 'qwe', time_zone: 1)

      post '/api/v1/users', params: { email: 'qwe@qwe.com', password: 'qwe' }

      expect(response).to have_http_status 201
      expect(json_response[:token]).to eq user.reload.token
    end
  end

  context '#signup' do
    it 'fails on incomplete data' do
      post '/api/v1/users/signup', params: { email: 'qwe@qwe.com', password: 'qwe' }

      expect(response).to have_http_status 400
    end

    it 'works' do
      expect do
        post '/api/v1/users/signup', params: { email: 'qwe@qwe.com', password: 'qwe', time_zone: 1 }

        expect(response).to have_http_status 201
      end.to change(::User, :count).by(1)
    end
  end

  context '#logout' do
    it 'does not fail for anonymous' do
      post '/api/v1/users/logout'

      expect(response).to have_http_status 201
    end

    it 'works' do
      expect do
        post '/api/v1/users/logout', params: { token: token }

        expect(response).to have_http_status 201

        signedin_user.reload
      end.to change(signedin_user, :token)
    end
  end

  context '#delete' do
    it 'fails for anonymous' do
      delete '/api/v1/users'

      expect(response).to have_http_status 401
    end

    it 'works' do
      signedin_user

      expect do
        delete '/api/v1/users', params: { token: token }

        expect(response).to have_http_status 200

        expect { signedin_user.reload }.to raise_error ActiveRecord::RecordNotFound
      end.to change(::User, :count).by(-1)
    end
  end

  context '#me' do
    it 'fails for anonymous' do
      get '/api/v1/users/me'

      expect(response).to have_http_status 401
    end

    it 'works' do
      signedin_user

      get '/api/v1/users/me', params: { token: token }

      expect(response).to have_http_status 200

      expect(json_response[:email]).to eq signedin_user.email
    end
  end

  context '#me update' do
    it 'fails for anonymous' do
      post '/api/v1/users/me'

      expect(response).to have_http_status 401
    end

    it 'works' do
      signedin_user

      post '/api/v1/users/me', params: { token: token, time_zone: 0 }

      expect(response).to have_http_status 201

      expect(signedin_user.reload.time_zone).to eq 0
    end
  end
end