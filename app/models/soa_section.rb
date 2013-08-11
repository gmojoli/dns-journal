class SoaSection < ActiveRecord::Base
  belongs_to :user
  belongs_to :dns_zone

  validates :dns_zone, presence: true
  validates :user_id, presence: true
  validates :primary_domain_name, :presence => true
  validates :serial_number, :refresh, :retry, :expire, :negative_caching, :numericality => { :only_integer => true }

  after_initialize :init

  def init
    self.serial_number ||= (Time.now.strftime("%Y%m%d") + (sprintf '%02d', max_revision.to_s)).to_i
    self.refresh ||= 0
    self.retry ||= 0
    self.expire ||= 0
    self.revision ||= 1
    self.negative_caching ||= 0
  end

  def zone_class
    'IN'
  end

  def max_revision
    (SoaSection.where('primary_domain_name' => primary_domain_name).where('user_id' => user_id).maximum(:revision) || 0) + 1
  end

end
