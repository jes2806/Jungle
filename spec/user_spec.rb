require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    subject {
      described_class.new(
        first_name: "John",
        last_name: "Sweeney",
        email: "testemail@test.com",
        password: "thisisapassword",
        password_confirmation: "thisisapassword"
      )
    }

    it "should be valid with all required inputs" do
      expect(subject).to be_valid  
    end

    it "should be invalid without first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "should be invalid without last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "should be invalid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "should be invalid without password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "should be invalid when password and password confirmation don't match" do
      subject.password_confirmation = "different"
      expect(subject).to_not be_valid
    end

    it "is is invalid is password less than 6 characters" do
      subject.password = 'pass'
      subject.password_confirmation = 'pass'
      expect(subject).to_not be_valid
    end

    it "is invalid for emails with same name, not case-sensitive" do
      @user1 = User.create(first_name: "Johnny", last_name: "Depp", email: "test23@test.com", password: "thisisapassword", password_confirmation: "thisisapassword")
      @user2 = User.create(first_name: "John", last_name: "Smith", email: "TEST23@test.com", password: "thisisapassword", password_confirmation: "thisisapassword")
      expect(@user2).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do

    it "verifys User is equal to authenticated user" do
      User.create(first_name: "Johnny", last_name: "Depp", email: "test23@test.com", password: "thisisapassword", password_confirmation: "thisisapassword")
      @user = User.authenticate_with_credentials("test23@test.com", "thisisapassword")
      expect(@user).to be_an_instance_of(User)
    end

    it "is valid with trailing or starting whitespaces in email" do
      User.create(first_name: "Johnny", last_name: "Depp", email: "test23@test.com", password: "thisisapassword", password_confirmation: "thisisapassword")
      @user = User.authenticate_with_credentials("      test23@test.com     ", "thisisapassword")
      expect(@user).to be_an_instance_of(User)
    end

    it "is valid with capitalized email and extra spaces at start or end of email" do
      User.create(first_name: "Johnny", last_name: "Depp", email: "test23@test.com", password: "thisisapassword", password_confirmation: "thisisapassword")
      @user = User.authenticate_with_credentials(" TeST23@tESt.COm     ", "thisisapassword")
      expect(@user).to be_an_instance_of(User)
    end
  end
end
