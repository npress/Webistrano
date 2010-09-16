class HostType < ActiveRecord::Base
  belongs_to :host
  belongs_to :server_type
  validates_uniqueness_of :server_type_id, :scope=>:host_id
end
