class AllowedIpAddressesController < ApplicationController
     before_filter :check_admin
  
     def index
    @ips = AllowedIpAddress.find(:all, :order => 'ip_address ASC')

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @ips.to_xml }
    end
  end
  
  # GET /allowed_ip_addresses/1
  # GET /allowed_ip_addresses/1.xml
  def show
    @ip = AllowedIpAddress.find(params[:id])
    #@stages = @host.stages.uniq.sort_by{|x| x.project.name}

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @ip.to_xml }
    end
  end

	# GET /allowed_ip_addresses/new
  def new
    @ip = AllowedIpAddress.new
  end

  # GET /allowed_ip_addresses/1;edit
  def edit
    @ip = AllowedIpAddress.find(params[:id])
  end

  # POST /allowed_ip_addresses
  # POST /allowed_ip_addresses.xml
  def create
    @ip = AllowedIpAddress.new(params[:ip])

    respond_to do |format|
      if @ip.save
        flash[:notice] = 'Allowed IP Address was successfully created.'
        format.html { redirect_to allowed_ip_address_path(@ip) }
        format.xml  { head :created, :location => allowed_ip_address_path(@ip) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ip.errors.to_xml }
      end
    end
  end
  
  # PUT /allowed_ip_addresses/1
  # PUT /allowed_ip_addresses/1.xml
  def update
    @ip = AllowedIpAddress.find(params[:id])

    respond_to do |format|
      if @ip.update_attributes(params[:ip])
        flash[:notice] = 'Host was successfully updated.'
        format.html { redirect_to allowed_ip_address_path(@ip) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ip.errors.to_xml }
      end
    end
  end

  # DELETE /allowed_ip_addresses/1
  # DELETE /allowed_ip_addresses/1.xml
  def destroy
    @ip = AllowedIpAddress.find(params[:id])
    @ip.destroy

    respond_to do |format|
      flash[:notice] = 'Allowed IP Address was successfully deleted.'
      format.html { redirect_to allowed_ip_address_path }
      format.xml  { head :ok }
    end
  end
end
