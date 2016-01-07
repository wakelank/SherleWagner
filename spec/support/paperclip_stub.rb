module Paperclip
  def run cmd, params = "", expected_outcodes = 0
    case cmd
    when "identify"
      return "100x100"
    when "convert"
      return
    else
      super
    end
  end
  def indentify
    return "100x100"
  end
  def convert
  end
end

class Paperclip::Attachment
  def post_process
  end
end
