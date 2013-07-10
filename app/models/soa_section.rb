class SoaSection < ActiveRecord::Base
  belongs_to :dns_zone
  validates :primary_domain_name, :presence => true
  validates :serial_number, :refresh, :retry, :expire, :negative_caching, :numericality => { :only_integer => true }

  after_initialize :init

  def init
    self.serial_number ||= (Time.now.strftime("%Y%m%d") + (sprintf '%02d', max_revision.to_s)).to_i
    self.refresh ||= 0
    self.retry ||= 0
    self.expire ||= 0
    self.negative_caching ||= 0
  end

  def zone_class
    'IN'
  end

  def max_revision
    (SoaSection.maximum(:revision) || 0) + 1
  end

end
