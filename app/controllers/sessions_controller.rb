class SessionsController < Devise::SessionsController
  def create
    super.tap do |session|
      gflash success: "Logged in"
    end
  end
  def destroy
    super.tap do |session|
      gflash success: "Logged out"
    end
  end
end
