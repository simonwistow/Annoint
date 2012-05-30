class Array
  def choose
    sort_by{ rand }[0]
  end
end