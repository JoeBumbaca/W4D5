require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_uniqueness_of(:username) }
  subject(:fred) { User.create(
      username: 'fred', 
      password: 'password'
    ) 
  }
  
  describe 'associations' do 
    it { should have_many(:goals) }
  end

  describe "self.find_by_credentials" do 
    before (:each) do  
      FactoryBot.create(:bob)
    end

    context "with valid credentials" do 
      it "should find the correct user" do
        bob = User.find_by_credentials(username: 'Bob', password: 'password123')
        expect(bob.username).to eq(User.last.username)
      end
    end

    context "with invalid credentials" do 
      it "should return nil" do
        invalid_user = User.find_by_credentials(username: 'Steve', password: 'password123')
        expect(invalid_user).to be nil
      end
    end
  end

end
