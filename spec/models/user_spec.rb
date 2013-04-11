require 'spec_helper'

describe User do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:account_type) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_presence_of(:postal_code) }
  it { should validate_presence_of(:street_address) }
end
