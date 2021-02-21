# frozen_string_literal: true

require 'rails_helper'

describe Message do
  describe 'validations' do
    it { expect(subject).to validate_presence_of(:text) }
    it { expect(subject).to validate_presence_of(:sender_id) }

    describe 'receiver' do
      it 'invalid' do
        message = Message.new(text: 'qwe', sender_id: 1, group_id: nil, user_id: nil)

        expect(message).not_to be_valid
        expect(message.errors[:group_id]).not_to be_empty
        expect(message.errors[:user_id]).not_to be_empty
      end

      describe 'valid' do
        let(:user) { User.create!(email: 'qwe2@qwe.com', password: 'qwe', time_zone: 1, group: ::Group.create!(name: 'qwe')) }

        it 'if user_id is present' do
          message = Message.new(text: 'qwe', sender: user, user: user)

          expect(message).to be_valid
        end

        it 'if group_id is present' do
          message = Message.new(text: 'qwe', sender: user, group: user.group)

          expect(message).to be_valid
        end
      end
    end
  end
end