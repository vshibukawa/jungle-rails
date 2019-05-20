require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe User, type: :model do

  describe 'Validations' do

    subject {
      User.new(
        first_name: 'User',
        last_name: 'Test',
        email: 'usery@test.com',
        password: 'user1234',
        password_confirmation: 'user1234'
      )
    }

    context 'when creating with password and password_confirmation' do
      it 'should require password' do
        subject.password = nil
        subject.save
        expect(subject.errors.full_messages[0].downcase).to include('password')
      end

      it 'should require password_confirmation' do
        subject.password_confirmation = nil
        subject.save
        expect(subject.errors.full_messages[0].downcase).to include('password confirmation')
      end

      it 'should match' do
        subject.password_confirmation = 'user1234@'
        subject.save
        expect(subject.errors.full_messages[0].downcase).to include('password')
      end
    end

    it 'should have an e-mail' do
      subject.email = nil
      subject.save

      expect(subject.errors.full_messages[0].downcase).to include('email')
    end

    it 'should have a first name' do
      subject.first_name = nil
      subject.save

      expect(subject.errors.full_messages[0].downcase).to include('first name')
    end

    it 'should have a last name' do
      subject.last_name = nil
      subject.save

      expect(subject.errors.full_messages[0].downcase).to include('last name')
    end

    it 'should have at least 8 characters in the password' do
      password = '1234567'
      subject.password = password
      subject.password_confirmation = password
      subject.save

      expect(subject.errors.full_messages[0].downcase).to include('password')
    end

    describe '.authenticate_with_credentials' do
      context 'when e-mail is already in the database' do
        it 'should return error case email is lowercase' do
          subject.email = 'user@test.com'
          subject.save

          expect(subject.errors.full_messages[0].downcase).to include('email')
        end

        it 'should return error case email is uppercase' do
          subject.email = 'USER@test.com'
          subject.save

          expect(subject.errors.full_messages[0].downcase).to include('email')
        end
      end
    end

    it 'should create user' do
      subject.save

      expect(subject).to be_valid
    end
  end

  describe 'Authentication' do

    before :all do
      @user = User.new(
        first_name: 'User',
        last_name: 'Test',
        email: 'user@test.com',
        password: 'user1234',
        password_confirmation: 'user1234'
      )
      @user.save
    end

    it 'should be true if the e-mail has spaces' do
      @user.email = " #{@user.email} "
      user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(user).to be_truthy
    end

    it 'should be false if user and passaword do not match' do
      user = User.authenticate_with_credentials(@user.email, "123456789")
      expect(user).to be_falsey
    end

    it 'should be true if user and passaword matches' do
      user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(user).to be_truthy
    end
  end
end
