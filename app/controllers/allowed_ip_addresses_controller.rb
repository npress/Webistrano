class AllowedIpAddressesController < ApplicationController
     def index
    @ips = AllowedIpAddress.find(:all, :order => 'ip_address ASC')

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @ips.to_xml }
    end
  end

	
end
