class String
  def underscore_all
    self.gsub(/[^a-zA-Z0-9]/, '_').gsub(/^_*|_*$/, '')
  end

  def remove_blank_line!
    self.gsub /^$\n/, ''
  end
end