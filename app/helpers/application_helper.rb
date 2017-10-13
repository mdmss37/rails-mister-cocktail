module ApplicationHelper
  def truncate_text(text, truncate_at)
    return "" if text.nil?
    if text.length >= truncate_at
      text[0..(truncate_at-3)].strip + "..."
    else
      text
    end
  end
end
