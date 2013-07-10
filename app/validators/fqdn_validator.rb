class FqdnValidator
  def self.validate_fqdn(fqdn)
    fqdn =~ /(?=^.{1,254}$)(^(?:(?!\d+\.)[a-zA-Z0-9_\-]{1,63}\.?)+(?:[a-zA-Z]{2,})$)/

    # (?=^.{1,254}$) matches domain names (that can begin with any char) that are long between 1 and 254 char, it could be also 5,254 if we assume co.uk is the minimum lenght.
    # (^ starting match
    # (?: define a matching group
    # (?!\d+\.) the domain name should not be composed by numbers, so 1234.co.uk or abc.123.uk aren't accepted while 1a.ko.uk yes.
    # [a-zA-Z0-9_\-] the domain names should be composed by words with only a-zA-Z0-9_-
    # {1,63} the lenght of any domain level is maximum 63 char, (it could be 2,63)
    # + and
    # (?:[a-zA-Z]{2,})$) the final part of the domain name should not be followed by any other word and must be composed of a word minumum of 2 char a-zA-Z
  end
end
