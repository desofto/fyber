# frozen_string_literal: true

require 'rails_helper'

describe Group do
  describe 'validations' do
    it { expect(subject).to validate_presence_of(:name) }
  end
end