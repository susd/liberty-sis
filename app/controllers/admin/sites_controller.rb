class Admin::SitesController < AdminController

  def index
    @sites = Site.order(:code)
  end

  def new
    @site = Site.new
  end

  def edit
    set_site
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to admin_sites_path, notice: 'Site saved'
    else
      render :new
    end
  end

  def update
    set_site
    if @site.update(site_params)
      redirect_to admin_sites_path, notice: 'Site saved'
    else
      render :edit
    end
  end

  private

  def set_site
    @site = Site.find params[:id]
  end

  def site_params
    params.require(:site).permit!
  end

end
