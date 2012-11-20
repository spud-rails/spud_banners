class Spud::Admin::BannerSetsController < ApplicationController

  before_filter :get_record, :only => [:show, :edit, :update, :destroy]
  respond_to :html
  belongs_to_spud_app :banner_sets
  add_breadcrumb 'Banner Sets', :spud_admin_banner_sets_path
  layout false

  def index
    @banner_sets = SpudBannerSet.all
    respond_with @banner_sets, :layout => 'spud/admin/detail'
  end

  def show
    respond_with @banner_set, :layout => 'spud/admin/detail'
  end

  def new
    @banner_set = SpudBannerSet.new
    respond_with @banner_set
  end

  def create
    @banner_set = SpudBannerSet.new(params[:spud_banner_set])
    if @banner_set.save
      flash[:notice] = 'BannerSet created successfully' 
      render 'create'
    else
      render 'new', :status => 422
    end
  end

  def edit
    respond_with @banner_set
  end

  def update
    if @banner_set.update_attributes(params[:spud_banner_set])
      flash[:notice] = 'BannerSet updated successfully'
      render 'create'
    else
      render 'edit', :status => 422
    end
  end

  def destroy
    flash[:notice] = 'BannerSet deleted successfully' if @banner_set.destroy
    respond_with @banner_set, :location => spud_admin_banner_sets_path
  end

private

  def get_record
    begin
      logger.debug "Looking for banner set with id: #{params[:id]}"
      @banner_set = SpudBannerSet.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:error] = "Could not find the requested BannerSet"
      redirect_to spud_admin_banner_sets_path
      return false
    end
  end

end