require 'rails_helper'

RSpec.describe User, type: :model do
  setup do
    @attrs = { email: "something@here.com", password: "12345678", password_confirmation: "12345678", name: "Michelle"}
  end
  describe 'Validations' do
    it "checks that password and password confirmation are the same" do
      @user = User.new({name: "Michelle", email: "test@test.com", password: "StrongPassword123", password_confirmation: "NotStrong"})
      expect(@user).to_not be_valid
    end

    it "checks that password is entered" do
      @user = User.new({name: "Michelle", email: "test@test.com"})
      expect(@user).to_not be_valid
    end
    
    it "validates that the email is unique" do
      assert User.create(@attrs)
      assert user = User.new(@attrs)
      expect(user).to_not be_valid
    end

    it "email validation is not case sensitive" do
      assert User.create(@attrs)
      assert user = User.new({email: "SOMETHING@here.COM",password: "12345678", password_confirmation: "12345678"})
      expect(user).to_not be_valid
    end
    
    it "validates that the name has been entered" do
      @user = User.new({email: "test@test.com", password: "StrongPassword123", password_confirmation: "StrongPassword123"})
      expect(@user).to_not be_valid
    end

    it "validates that password has at least 8 characters" do
      @user = User.new({email: "test@test.com", password: "Strong", password_confirmation: "Strong"})
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "should log the user in if the correct email and password are entered" do
      @user = User.create!(name:"bob", email: 'bob@example.com', password: 'password12', password_confirmation: 'password12')
      user = User.authenticate_with_credentials('bob@example.com', 'password12')
      expect(user).to eq(@user)
    end

    it "should make sure that the correct email and password are entered" do
      @user = User.create!({name: "Michelle", email: "test@test.com", password: "StrongPassword123", password_confirmation: "StrongPassword123"})
      user = User.authenticate_with_credentials("test@test.com", "notcorrect")
      expect(user).to be_nil
    end

    it "should sign in the user even if the email has extra spaces" do
      @user = User.create!({name: "Michelle", email: "test@test.com", password: "StrongPassword123", password_confirmation: "StrongPassword123"})
      @email = "     test@test.com"
      @password = "StrongPassword123"
      user = User.authenticate_with_credentials(@email, @password)
      expect(user).to eq(@user)
    end

    it "should sign in the user even if the email has wrong case" do
      @user = User.create!({name: "Michelle", email: "test@test.com", password: "StrongPassword123", password_confirmation: "StrongPassword123"})
      @email = "TEST@test.Com"
      @password = "StrongPassword123"
      user = User.authenticate_with_credentials(@email, @password)
      expect(user).to eq(@user)
    end
  end
end
