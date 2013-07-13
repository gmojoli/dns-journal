module ApplicationHelper
  def title(page_title='DNS Journal')
    content_for(:title) { page_title }
  end
end
