class SoaSection < ActiveRecord::Base
  belongs_to :user
  belongs_to :dns_zone

  validates :dns_zone, presence: true
  validates :user_id, presence: true
  validates :primary_domain_name, :presence => true
  validates :mname, :presence => true
  validates :rname, :presence => true
  validates :serial_number, :refresh, :retry, :expire, :minimum, :numericality => { :only_integer => true }

  after_initialize :init

  def init
    self.serial_number ||= (Time.now.strftime("%Y%m%d") + (sprintf '%02d', max_revision.to_s)).to_i
    self.refresh ||= 86000
    self.retry ||= 7200
    self.expire ||= 3600000
    self.minimum ||= 600
    self.revision ||= 1
  end

  def zone_class
    'IN'
  end

  def max_revision
    (SoaSection.where('primary_domain_name' => primary_domain_name).where('user_id' => user_id).maximum(:revision) || 0) + 1
  end

end
