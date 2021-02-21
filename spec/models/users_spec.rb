# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe 'validations' do
    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to validate_presence_of(:time_zone) }
    it { expect(subject).to validate_numericality_of(:time_zone) }
  end

  it '#authenticate' do
    user = User.create(email: 'qwe@qwe.com', password: 'QWEqwe123', time_zone: 1)

    expect(user.authenticate('qwe')).to be_falsey
    expect(user.token).to be_blank
    expect(user.authenticate('QWEqwe123')).to be_truthy
    expect(user.token).not_to be_blank
  end
end