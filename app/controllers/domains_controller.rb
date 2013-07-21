class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /domains
  # GET /domains.json
  def index
    @domains = current_user.domains
  end

  # GET /domains/1
  # GET /domains/1.json
  def show
  end

  # GET /domains/new
  def new
    @domain = Domain.new
  end

  # GET /domains/1/edit
  def edit
  end

  # POST /domains
  # POST /domains.json
  def create
    @domain = Domain.new(domain_params.merge({:user_id => current_user.id}))
    # current_user.domains << @domain.user_id = current_user.id
    respond_to do |format|
      if @domain.save
        format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
        format.json { render action: 'show', status: :created, location: @domain }
      else
        format.html { render action: 'new' }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /domains/1
  # PATCH/PUT /domains/1.json
  def update
    respond_to do |format|
      if @domain.update(domain_params)
        format.html { redirect_to @domain, notice: 'Domain was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.json
  def destroy
    @domain.destroy
    respond_to do |format|
      format.html { redirect_to domains_url }
      format.json { head :no_content }
    end
  end

  def select_dns_zone
    set_domain
    dns_zone = DnsZone.find_by(id: params[:dns_zone])
    respond_to do |format|
      if dns_zone && dns_zone.soa_section && (@domain.current_dns_zone = params[:dns_zone]) && @domain.save
        format.html { redirect_to @domain, notice: 'Domain was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @domain, alert: 'Dns Zone without SOA section!' }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  def export_zone(dns_zone_id)
    dns_zone = DnsZone.find(dns_zone_id)
    file_content = "$ORIGIN: #{dns_zone.origin}. TTL: #{dns_zone.ttl} ;"
    file_content.concat "\n#{dns_zone.origin}. #{dns_zone.soa_section.zone_class} SOA #{dns_zone.soa_section.primary_domain_name}. (#{dns_zone.soa_section.serial_number} #{dns_zone.soa_section.refresh} #{dns_zone.soa_section.retry} #{dns_zone.soa_section.expire} #{dns_zone.soa_section.negative_caching}) ;"
    dns_zone.resource_records.each do |rr| 
      file_content.concat "\n#{rr.name} IN #{rr.type} #{rr.value} #{rr.option || ''} ;"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      unless @domain = current_user.domains.where(id: params[:id]).first
        flash[:alert] = 'Domain not found.'
        redirect_to domains_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_params
      params.require(:domain).permit(:name, :note)
    end
end
