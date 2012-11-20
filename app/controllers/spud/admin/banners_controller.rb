class Spud::Admin::BannersController < ApplicationController

  before_filter :get_record, :only => [:edit, :update, :destroy]
  respond_to :html, :json, :xml
  
  def new
    @banner = Banner.new
    respond_with @banner
  end
  
  def create
    @banner = Banner.new(params[:banner])
    flash[:notice] = 'Banner created successfully' if @banner.save
    respond_with @banner, :location => spud_admin_banner_set_path(@banner.owner)
  end
  
  def edit
    respond_with @banner
  end
  
  def update
    if @banner.update_attributes(params[:banner])
      flash[:notice] = 'Banner updated successfully'
    end
    respond_with @banner, :location => spud_admin_banner_set_path(@banner.owner)
  end
  
  def destroy
    flash[:notice] = 'Banner deleted successfully' if @banner.destroy
    respond_with @banner, :location => spud_admin_banner_set_path(@banner.owner)
  end

private

  def get_record
    begin
      @banner = Banner.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:error] = "Could not find the requested Banner"
      redirect_to spud_admin_banner_sets_path
      return false
    end
  end

end