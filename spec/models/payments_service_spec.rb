require 'spec_helper'

describe PaymentsService do
  
  before(:each) do
    VCR.use_cassette('balance_config', :match_requests_on => [:uri]) do
      @payments_service = PaymentsService.new
    end
    @user = User.create!( email: 'test@example.com',
                       password: 'abcd',
                       password_confirmation: 'abcd',
                       name: 'Timmy Q. CopyPasta',
                       account_type: 'person',
                       phone_number: '+14089999999',
                       street_address: '121 Skriptkid Row',
                       postal_code: '94110',
                       dob: '1989-12' )
  end
  
  
  it "creates a seller account" do
    VCR.use_cassette('create_seller_account', :match_requests_on => [:uri]) do 
      expect(@payments_service.create_seller(@user.id)).to be_nil
      #expect(@user.uri).to be_true
    end
  end
  
  it "adds bank account to a seller account" do
    VCR.use_cassette('add_bank_account', :match_requests_on => [:uri]) do
      bank_uri = "/v1/bank_accounts/BA9JdKOPnzX0W2yKKTvyJD0"
      @payments_service.add_bank_account(@user.id, bank_uri)
      #expect(@user.bank_uri).to eq bank_uri
    end
  end 
end
