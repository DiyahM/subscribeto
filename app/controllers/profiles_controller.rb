class ProfilesController < InheritedResources::Base
  before_filter :authorize

  def show
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.profile 
  end

  def update
    current_user.profile.update_attributes(params[:profile])

    respond_to do |format|
      format.html { redirect_to user_profile_path(current_user), notice: 'Profile was successfully updated.' }
      format.json { head :no_content }
    end
  end

end
