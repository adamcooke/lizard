require 'lizard'

module Lizard

  COLOR_PROFILES = {
    'CMYK' => File.join(root, 'colorspaces', 'CMYK', 'CoatedFOGRA39.icc'),
    'RGB'  => File.join(root, 'colorspaces', 'RGB', 'sRGB_IEC61966-2-1_no_black_scaling.icc')
  }

end
