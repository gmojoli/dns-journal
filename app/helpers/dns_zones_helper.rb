module DnsZonesHelper
  def print_errors
     @dns_zone.errors.messages
  end

  def seconds_to_readable_time(seconds)
    mm, ss = seconds.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    string =
    if dd > 0
      "%d days, %d hours, %d minutes, %d seconds" % [dd, hh, mm, ss]
    elsif hh > 0
      "%d hours, %d minutes, %d seconds" % [hh, mm, ss]
    elsif mm > 0
      "%d minutes, %d seconds" % [mm, ss]
    else
      "%d seconds" % ss
    end
    string
  end
end
