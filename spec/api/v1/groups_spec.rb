# frozen_string_literal: true

require 'rails_helper'

describe 'API::V1::Groups', type: :controller do
  it '#index' do
    group1 = Group.create!(name: 'qwe1')
    group2 = Group.create!(name: 'qwe2')

    get '/api/v1/groups'

    expect(response).to have_http_status 200
    expect(json_response.map { |group| group[:id] }).to match_array [group1.id, group2.id]
  end

  it '#show' do
    user = User.create!(email: 'qwe@qwe.com', password: 'qwe', time_zone: 1)
    user.authenticate('qwe')

    group1 = Group.create!(name: 'qwe1')
    group2 = Group.create!(name: 'qwe2')

    get "/api/v1/groups/#{group1.id}", params: { token: user.token }

    expect(response).to have_http_status 200
    expect(json_response[:name]).to eq 'qwe1'
  end
end