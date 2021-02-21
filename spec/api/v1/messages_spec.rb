# frozen_string_literal: true

require 'rails_helper'

describe 'API::V1::Messages', type: :controller do
  let(:signedin_user) {
    user = User.create!(email: 'qwe@qwe.com', password: 'qwe', time_zone: 1)
    user.authenticate('qwe')
    user
  }

  let(:token) {
    signedin_user.token
  }

  let(:user) { User.create!(email: 'qwe2@qwe.com', password: 'qwe', time_zone: 1) }

  context '#index' do
    it 'fails for anonymouse user' do
      get '/api/v1/messages'
      expect(response).to have_http_status 401
    end

    it 'works for legal user' do
      signedin_user.update!(group: ::Group.create(name: 'qwe'))
      user.update!(group: ::Group.create(name: 'qwe2'))

      message1 = ::Message.create!(text: 'qwe', user: signedin_user, sender: user)
      message2 = ::Message.create!(text: 'qwe', group: signedin_user.group, sender: user)
      ::Message.create!(text: 'qwe', user: user, sender: user)
      ::Message.create!(text: 'qwe', group: user.group, sender: user)

      get '/api/v1/messages', params: { token: token }

      expect(response).to have_http_status 200
      expect(json_response.map { |msg| msg[:id] }).to match_array [message1.id, message2.id]
    end
  end

  context '#create' do
    context 'fails' do
      it 'for anonymouse user' do
        post '/api/v1/messages', params: { text: 'qwe', user_id: user.id }
        expect(response).to have_http_status 401
      end

      it 'on incomplete data' do
        post '/api/v1/messages', params: { token: token, text: 'qwe' }

        expect(response).to have_http_status 422
      end
    end

    it 'works' do
      user.update!(group: ::Group.create(name: 'qwe'))

      expect do
        post '/api/v1/messages', params: { token: token, text: 'qwe', user_id: user.id, group_id: user.group.id }

        expect(response).to have_http_status 201
      end.to change(::Message, :count).by(1)

      msg = ::Message.take

      expect(msg.text).to eq 'qwe'
      expect(msg.user_id).to eq user.id
      expect(msg.group_id).to eq user.group.id
      expect(msg.sender_id).to eq signedin_user.id
    end
  end
end