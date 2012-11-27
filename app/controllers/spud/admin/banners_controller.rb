class Spud::Admin::BannersController < Spud::Admin::ApplicationController

  include RespondsToParent

  cache_sweeper :spud_banner_sweeper, :only => [:create, :update, :destroy]
  before_filter :get_set, :only => [:new, :create]
  before_filter :get_record, :only => [:edit, :update, :destroy]
  respond_to :html
  layout false

  def new
    @banner = @banner_set.banners.new
    respond_with @banner
  end

  def create
    @banner = @banner_set.banners.build
    @banner.attributes = params[:spud_banner]

    last_banner = SpudBanner.select('sort_order').where(:spud_banner_set_id => @banner_set.id).order('sort_order desc').first
    if last_banner
     @banner.sort_order = last_banner.sort_order + 1
    end

    if request.xhr?
      if @banner.save
        flash.now[:notice] = 'SpudBanner created successfully' 
        render 'show'
      else
        render 'new', :status => 422
      end
    else
      @banner.save
      respond_to_parent do
        render 'legacy', :formats => [:js]
      end
    end
  end

  def edit
    respond_with @banner
  end

  def update
    if request.xhr?
      if @banner.update_attributes(params[:spud_banner])
        flash.now[:notice] = 'SpudBanner created successfully' 
        render 'show'
      else
        render 'edit', :status => 422
      end
    else
      @banner.update_attributes(params[:spud_banner])
      respond_to_parent do
        render 'legacy', :formats => [:js]
      end
    end
  end

  def destroy
    if @banner.destroy
      flash.now[:notice] = 'SpudBanner deleted successfully' 
      status = 200
    else
      status = 422
    end
    render :nothing => true, :status => status
  end

  def sort
    banner_ids = params[:spud_banner_ids]
    banners = SpudBanner.where(:id => banner_ids).to_a
    SpudBanner.transaction do
      banner_ids.each_with_index do |id, index|
        banner = banners.select{ |b| b.id == id.to_i }.first
        banner.update_attribute(:sort_order, index)
      end
    end
    render :nothing => true, :status => 200
  end

private

  def get_set
    begin
      @banner_set = SpudBannerSet.find(params[:banner_set_id])
    rescue ActiveRecord::RecordNotFound => e
      flash.now[:error] = "Could not find the requested SpudBannerSet"
      render :nothing => true, :status => 404
      return false
    end
  end

  def get_record
    begin
      @banner = SpudBanner.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      flash.now[:error] = "Could not find the requested SpudBanner"
      redirect_to spud_admin_banner_sets_path
      return false
    end
  end

end