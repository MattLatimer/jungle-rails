require 'rails_helper'

RSpec.describe User, type: :model do

 before(:each) do
  @user = User.create({
    name: 'a',
    email: 'a@a.a',
    password: 'password',
    password_confirmation: 'password'
  })
 end

  describe 'Validations' do
    it 'should be valid with all fields' do
      expect(@user).to be_valid
    end

    it 'should have a unique email address, case insensitive' do
      @user2 = User.new({
        name: 'a',
        email: 'A@A.A',
        password: 'password',
        password_confirmation: 'password'
      })
      expect(@user).to be_valid
      expect(@user2).to be_invalid
      expect(@user2.errors[:email]).to include('has already been taken')
    end

    it 'should reject if passwords do not match' do
      @user.password_confirmation = 'passwrd'
      expect(@user).to be_invalid
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'should reject if password is missing' do
      @user.password = nil
      expect(@user).to be_invalid
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'should reject if password is too short' do
      @user.password = '1234',
      @user.password_confirmation = '1234'
      expect(@user).to be_invalid
      expect(@user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end

    it 'should reject if email is missing' do
      @user.email = nil
      expect(@user).to be_invalid
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'should reject if name is missing' do
      @user.name = nil
      expect(@user).to be_invalid
      expect(@user.errors[:name]).to include("can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate with proper credentials' do
      user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(user).to_not be_nil
    end
  end
end
