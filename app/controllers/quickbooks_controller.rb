class QuickbooksController < ApplicationController

  def authenticate
    callback = quickbooks_oauth_callback_url
    token = $qb_oauth_consumer.get_request_token(:oauth_callback => callback)
    session[:qb_request_token] = token
    redirect_to("https://appcenter.intuit.com/Connect/Begin?oauth_token=#{token.token}") and return
  end

  def oauth_callback
    at = session[:qb_request_token].get_access_token(:oauth_verifier => params[:oauth_verifier])
    token = at.token
    secret = at.secret
    realm_id = params['realmId']
    current_user.update_attributes(qb_token: token, qb_secret: secret, qb_realm_id: realm_id)
    redirect_to edit_user_path(current_user)
    # store the token, secret & RealmID somewhere for this user, you will need all 3 to work with Quickeebooks
  end

end
