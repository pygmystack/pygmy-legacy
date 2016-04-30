module InstVarsToHash
  def to_s
    to_h.to_s
  end

  def to_h
    retval = {}
    instance_variables.each do |iv|
      retval[iv.to_s.delete('@').to_sym] = elem_to_h(instance_variable_get(iv))
    end
    retval
  end

  private

  def expandable_classes
    [ InstVarsToHash ]
  end

  def expandable_to_hash(klass)
    expandable_classes.any?{ |k| klass == k || klass < k }
  end

  def elem_to_h(elem)
    if elem.class == Array
      elem.map { |el| elem_to_h(el) }
    elsif expandable_to_hash(elem.class)
      elem.to_h
    else
      elem
    end
  end
end
