require 'rails_helper'
# require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_confirmation_of :password }
  # it { should :encrypt_password before_save}

  describe 'User#encrypt_password' do
    it ("should encrypt the password before it is saved") do
      user = User.new({ password: "thisisapassword", admin: false})
      expect(user.encrypt_password).not_to eq("thisisapassword")
    end
  end

  describe 'User.authenticate' do
    it ("should return the user if authentication succeeds") do
      user = User.create({email: "email@gmail.com", password: "password"})
      expect(User.authenticate("email@gmail.com", "password").email).to eq(user.email)
    end
    it ("should return the user if authentication succeeds") do
      user = User.create({email: "email@gmail.com", password: "password"})
      expect(User.authenticate("email@gmail.com", "pazzword")).to eq(nil)
    end
  end

end