class SessionsController < Devise::SessionsController
  def create
    super.tap do |session|
      logger.debug "#{session}"
    end
  end
  def destroy
    super.tap do |session|
      logger.debug "#{session}"
    end
  end
end
