class DnsZonesController < ApplicationController
  before_action :set_dns_zone, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  load_and_authorize_resource :domain, :find_by => :slug
  load_and_authorize_resource :dns_zone, :through => :domain

  # GET /dns_zones
  # GET /dns_zones.json
  def index
    @dns_zones = DnsZone.all
  end

  # GET /dns_zones/1
  # GET /dns_zones/1.json
  def show
  end

  # GET /dns_zones/new
  def new
    @dns_zone = DnsZone.new(:version => 1)
  end

  # GET /dns_zones/1/edit
  def edit
  end

  # POST /dns_zones
  # POST /dns_zones.json
  def create
    @domain = Domain.friendly.find(params[:domain_id])
    @dns_zone = @domain.dns_zones.create(dns_zone_params.merge({:version => 1}))
    if @dns_zone.save
      redirect_to @domain, notice: 'Dns zone was successfully created.'
    else
      render action: 'edit', @errors => @dns_zone.errors, alert: "Dns zone validation failed."
    end
  end

  # PATCH/PUT /dns_zones/1
  # PATCH/PUT /dns_zones/1.json
  def update
    respond_to do |format|
      zone = @dns_zone.deep_clone
      if (zone.update(dns_zone_params.merge( {:version => @dns_zone.new_version} ))) && zone.valid?
        zone.save!
        @dns_zone.domain.dns_zones << zone
        @dns_zone.domain.save
        format.html { redirect_to @dns_zone.domain, notice: 'Dns zone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html do
          flash[:alert] = "Dns zone validation failed."
          render action: :edit
        end
        format.json { render json: @dns_zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dns_zones/1
  # DELETE /dns_zones/1.json
  def destroy
    respond_to do |format|
      if @dns_zone.domain.dns_zone != @dns_zone && @dns_zone.destroy
        format.html { redirect_to @dns_zone.domain, notice: 'Dns zone was successfully deleted.'  }
        format.json { head :no_content }
      else
        format.html { redirect_to @dns_zone.domain, alert: 'Dns_zone in use!' }
        format.json { render json: @tag, status: :has_nodes }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dns_zone
      unless @dns_zone = current_user.dns_zones.where(id: params[:id]).first
        flash[:alert] = 'DnsZone not found.'
        redirect_to domains_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dns_zone_params
      params.require(:dns_zone).permit(:admin_email, :version, :origin, :ttl, :description, :user_id).tap do |dns_zone_params|
        dns_zone_params.merge!({:user_id => current_user.id})
      end
    end
end
