require 'rails_helper'

RSpec.describe User, type: :model do
  setup do
    @attrs = { email: "something@here.com", password: "123456", password_confirmation: "123456", name: "Michelle"}
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
      assert user = User.new({email: "SOMETHING@here.COM",password: "123456", password_confirmation: "123456"})
      expect(user).to_not be_valid
    end
    
    it "validates that the name has been entered" do
      @user = User.new({email: "test@test.com", password: "StrongPassword123", password_confirmation: "StrongPassword123"})
      expect(@user).to_not be_valid
    end

    
  end
end
