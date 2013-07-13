class SoaSectionsController < ApplicationController
  before_action :set_soa_section, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  # GET /soa_sections
  # GET /soa_sections.json
  def index
    @soa_sections = SoaSection.all
  end

  # GET /soa_sections/1
  # GET /soa_sections/1.json
  def show
  end

  # GET /soa_sections/new
  def new
    @soa_section = SoaSection.new
  end

  # GET /soa_sections/1/edit
  def edit
  end

  # POST /soa_sections
  # POST /soa_sections.json
  def create
    @dns_zone = DnsZone.find(params[:dns_zone_id])
    @soa_section = SoaSection.new(soa_section_params.merge({:user_id => current_user.id}))

    respond_to do |format|
      if @soa_section.save
        @dns_zone.soa_section = @soa_section
        format.html { redirect_to domain_dns_zone_path(@dns_zone.domain, @dns_zone), notice: 'Soa section was successfully created.' }
        format.json { render action: 'show', status: :created, location: @soa_section }
      else
        format.html { redirect_to domain_dns_zone_path(@dns_zone.domain, @dns_zone), alert: "SoaSection validation failed: #{@soa_section.errors.messages}" }
        format.json { render json: @soa_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /soa_sections/1
  # PATCH/PUT /soa_sections/1.json
  def update
    respond_to do |format|
      if @soa_section.update(soa_section_params)
        format.html { redirect_to domain_dns_zone_path(@soa_section.dns_zone.domain, @soa_section.dns_zone), notice: 'Soa section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to domain_dns_zone_path(@dns_zone.domain, @dns_zone), alert: "SoaSection validation failed: #{@soa_section.errors.messages}" }
        format.json { render json: @soa_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /soa_sections/1
  # DELETE /soa_sections/1.json
  def destroy
    @soa_section.destroy
    respond_to do |format|
      format.html { redirect_to domain_dns_zone_path(@soa_section.dns_zone.domain, @soa_section.dns_zone) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_soa_section
      unless @soa_section = current_user.soasections.where(id: params[:id]).first
        flash[:alert] = 'SoaSection not found.'
        redirect_to domains_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def soa_section_params
      params.require(:soa_section).permit(:primary_domain_name, :zone_class, :mname, :rname, :serial_number, :refresh, :retry, :expire, :negative_caching)
    end
end
