class AllowedIpAddress < ActiveRecord::Base
  validates_uniqueness_of :ip_address
  validates_presence_of :ip_address
  validates_length_of :ip_address, :maximum => 250
  
  attr_accessible :ip_address
  
  before_validation :strip_whitespace
  
  def strip_whitespace
    self.ip_address = self.ip_address.strip rescue nil
  end
  
  def validate
    errors.add("name", "is not a valid pattern or IP") unless ( valid_pattern? || valid_ip? )
  end
  
   def valid_pattern?
    self.ip_address =~ /\A[a-zA-Z0-9\_\-\.\*]+\Z/
  end
  
  def valid_ip?
    if self.ip_address =~ /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/
      ($1.to_i <= 255) && ($2.to_i <= 255) && ($3.to_i <= 255) && ($4.to_i <= 255)
    else
      false
    end
  end
end
