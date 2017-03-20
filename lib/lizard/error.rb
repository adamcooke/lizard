module Lizard

  class Error < StandardError
  end

  class NotAnImage < Error
  end

  class ResizeFailed < Error
  end

  class CropFailed < Error
  end

end
