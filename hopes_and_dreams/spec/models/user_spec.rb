require 'rails_helper'

RSpec.describe User, type: :model do


  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_uniqueness_of(:username) }
  subject(:fred) { User.create!(
      username: 'fred', 
      password: 'password'
    ) 
  }
  
  describe 'associations' do 
    it { should have_many(:goals) }
  end

  describe "self.find_by_credentials" do 
    
    context "with valid credentials" do 
      it "should find the correct user" do
        User.create!(username: "Bob", password: 'password123')
        # FactoryBot.create(:bob)
        #debugger
        result = User.find_by_credentials('Bob','password123')
        expect(result.username).to eq('Bob')
      end
    end

    context "with invalid credentials" do 
      it "should return nil" do
        # FactoryBot.create(:bob)
        User.create!(username: "Bob", password: 'password123')
        invalid_user = User.find_by_credentials('Steve', 'password123')
        expect(invalid_user).to be nil
      end
    end
  end

end
