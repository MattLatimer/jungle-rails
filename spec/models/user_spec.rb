require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be valid with all fields' do
      @user = User.create!({
        name: 'a',
        email: 'a@a.a',
        password: 'password',
        password_confirmation: 'password'
      })
      expect(@user).to be_valid
    end

    it 'should have a unique email address, case insensitive' do
      @user = User.create!({
        name: 'a',
        email: 'a@a.a',
        password: 'password',
        password_confirmation: 'password'
      })
      @user2 = User.create({
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
      @user = User.create({
        name: 'a',
        email: 'a@a.a',
        password: 'password',
        password_confirmation: 'passwrd'
      })
      expect(@user).to be_invalid
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'should reject if password is missing' do
      @user = User.create({
        name: 'a',
        email: 'a@a.a',
        password: nil,
        password_confirmation: nil
      })
      expect(@user).to be_invalid
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'should reject if password is too short' do
      @user = User.create({
        name: 'a',
        email: 'a@a.a',
        password: '1234',
        password_confirmation: '1234'
      })
      expect(@user).to be_invalid
      expect(@user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end

    it 'should reject if email is missing' do
      @user = User.create({
        name: 'a',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      })
      expect(@user).to be_invalid
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'should reject if name is missing' do
      @user = User.create({
        name: nil,
        email: 'a@a.a',
        password: 'password',
        password_confirmation: 'password'
      })
      expect(@user).to be_invalid
      expect(@user.errors[:name]).to include("can't be blank")
    end
  end
end
