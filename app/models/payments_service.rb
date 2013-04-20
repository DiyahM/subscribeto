class PaymentsService

  def initialize()
=begin
    @balanced = Balanced.configure(ENV['BALANCED_API_KEY'])
    @marketplace = Balanced::Marketplace.my_marketplace
=end
  end

  def create_seller(user_id)
    user = User.find(user_id)
    account_data = { name: user.name, email_address: user.email }
    #account = @marketplace.create_account(account_data)
    merchant_data = {
      phone_number: user.phone_number,
      name: user.name,
      dob: user.dob,
      postal_code: user.postal_code,
      type:  user.account_type,
      street_address: user.street_address
    }
    begin
      #resp = account.promote_to_merchant(merchant_data)
    rescue Balanced::MoreInformationRequired => error
      # could not identify this account.
      return "Could not create account for merchant. Please call."
      puts 'redirect merchant to: ' + error.redirect_uri
    rescue Balanced::Error => error
      # TODO: handle 400 and 409 exceptions as required
      raise
    end
    #user.uri = ADD real response uri here
    user.uri = "/v1/marketplaces/TEST-MP6E3EVlPOsagSdcBNUXWBDQ/accounts/ACbd9DtgwFTa0XERkMl7xnI"
    user.save
    return nil 
  end

  def add_bank_account(user_id, bank_uri)
    user = User.find(user_id)
    #account = Balanced::Account.find(user.uri)
    #account.add_bank_account(bank_uri)
    user.bank_uri = bank_uri
    user.save
  end
end
