class Dev < Monad
  def pass &block
    Dev.pure block.call value
  end

  def method_missing name, *args
    pass do |v|
      begin
        v.send name, *args
      rescue NoMethodError
        v.instance_variable_get :"@#{name}"
      end
    end
  end
end
