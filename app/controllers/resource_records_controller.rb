class ResourceRecordsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /resource_records/1
  # GET /resource_records/1.json
  def show
  end

  # GET /resource_records/new
  def new
    binding.pry
    @domain = Domain.friendly.find(params[:domain_id])
    @dns_zone = DnsZone.find(params[:dns_zone_id])
    @resource_record ||= ResourceRecord.new
    @resource_record.dns_zone = @dns_zone

  end

  # GET /resource_records/1/edit
  def edit
  end

  # POST /resource_records
  # POST /resource_records.json
  def create
    @dns_zone = DnsZone.find(params[:dns_zone_id])
    @resource_record = ResourceRecord.new(resource_record_params.merge({:user_id => current_user.id}))
    @dns_zone.resource_records << @resource_record
    respond_to do |format|
      if @resource_record.save
        format.html { redirect_to domain_dns_zone_path(@dns_zone.domain, @dns_zone), notice: 'Resource record was successfully created.' }
        format.json { render action: 'show', status: :created, location: @resource_record }
      else
        # format.html { redirect_to new_domain_dns_zone_resource_record_path(@resource_record.dns_zone.domain, @resource_record.dns_zone), alert: "Resource Record validation failed: #{@resource_record.errors.messages}" }
        format.html { render action: :new }
        format.json { render json: @resource_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resource_records/1
  # PATCH/PUT /resource_records/1.json
  def update
    respond_to do |format|
      if @resource_record.update(resource_record_params)
        format.html { redirect_to domain_dns_zone_path(@resource_record.dns_zone.domain, @resource_record.dns_zone), notice: 'Resource record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_domain_dns_zone_resource_record_path(@resource_record.dns_zone.domain, @resource_record.dns_zone, @resource_record), alert: "Resource Record validation failed: #{@resource_record.errors.messages}" }
        format.json { render json: @resource_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource_records/1
  # DELETE /resource_records/1.json
  def destroy
    @resource_record.destroy
    respond_to do |format|
      format.html { redirect_to domain_dns_zone_path(@resource_record.dns_zone.domain, @resource_record.dns_zone) }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_resource_record
      unless @resource_record = current_user.resource_records.where(id: params[:id]).first
        flash[:alert] = 'ResourceRecord not found.'
        redirect_to domains_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_record_params
      params.require(:resource_record).permit(:name, :resource_type, :value, :rfc, :description, :option)
    end
end
