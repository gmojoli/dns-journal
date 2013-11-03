module ApplicationHelper
  def title(page_title='DNS Journal')
    content_for(:title) { page_title }
  end
  def user_signed_in?
    !!current_user
  end
end
