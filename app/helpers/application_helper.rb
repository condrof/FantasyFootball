module ApplicationHelper
  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end
  
  def markdown(text)
   markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
   markdown.render(text).html_safe
  end
  
    @my_blockquote = {
    'Quote' => [
      /\[quote\](.*?)\[\/quote\1?\]/mi,
      '<blockquote>\3</blockquote>',
      'Quote with citation',
      '[quote=mike]please quote me[/quote]',
      :quote
    ],
  }
end
