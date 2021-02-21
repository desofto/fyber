# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe 'validations' do
    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to validate_presence_of(:time_zone) }
    it { expect(subject).to validate_numericality_of(:time_zone) }
  end

end