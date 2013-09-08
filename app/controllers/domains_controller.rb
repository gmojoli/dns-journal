require 'tempfile'

class DomainsController < ApplicationController

  # Gotcha! Custom find here...
  before_action :set_domain, only: [:show, :edit, :update, :destroy, :export_zone]
  before_filter :authenticate_user!
  load_and_authorize_resource only: [:show, :edit, :update, :destroy, :export_zone]

  VERSION = 0.1

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

  def export_zone
    dns_zone = DnsZone.find(params[:dns_zone])
    respond_to do |format|
      if dns_zone
        format.html do
          begin
            file_content = "#{header}\n"
            file_content.concat "$ORIGIN #{dns_zone.origin}.\n$TTL #{dns_zone.ttl}\n"
            if dns_zone.soa_section
              file_content.concat "#{dns_zone.origin}. #{dns_zone.soa_section.zone_class} SOA #{dns_zone.soa_section.primary_domain_name} #{dns_zone.admin_email}. "
              file_content.concat "(\n\t#{dns_zone.soa_section.serial_number} ; serial\n\t#{dns_zone.soa_section.refresh} ; refresh after #{dns_zone.soa_section.refresh} seconds\n\t#{dns_zone.soa_section.retry} ; retry after #{dns_zone.soa_section.retry} seconds\n\t#{dns_zone.soa_section.expire} ; expire after #{dns_zone.soa_section.expire} seconds\n\t#{dns_zone.soa_section.negative_caching} ; negative caching\n)\n"
            end
            file_content.concat "; -- resource records\n"
            Array(dns_zone.resource_records).each do |rr|
              file_content.concat "; #{ResourceRecord.definitions.fetch(rr.resource_type)[0]}\n"
              file_content.concat "#{rr.to_code_string}\n"
            end
            # Tempfile.open('prefix', Rails.root.join('tmp') ) do |f|
            #   f.print file_content
            #   f.flush
            # end
            send_data( file_content, :filename => "#{@domain.name}.txt" )
            flash[:notice] = 'File exported'
          rescue Exception => e
            flash[:alert] = "Something went wrong... (#{e.message})"
          ensure
            # can't render the flash?
          end
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      unless @domain = Domain.friendly.find(params[:id])
        flash[:alert] = 'Domain not found.'
        redirect_to domains_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_params
      params.require(:domain).permit(:name, :note)
    end

    def header
      "; -- zonefile created with Dns-Journal (#{VERSION}) - #{Date.today}"
    end

end
