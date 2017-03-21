# Lizard - a simple interface to ImageMagick CLI

Lizard is a very simple library that sits atop of a the `convert` and `identify` ImageMagick commands. It's not the fastest image processor in the world but it does it's job. It's job is:

* Reliably identify if a file is an image or not
* Get image information from an image - size, resolution, etc...
* Resize an image to any other size
* Identify the colors in an image and return an array of them

## Installation

```ruby
gem 'lizard', '~> 1.0'
```

## Usage

```ruby
image = Lizard::Image.new(image_data)
image.type        #=> "JPEG"
image.width       #=> 200
image.height      #=> 400

# Resize the image
resized_image = image.resize(200, 200)
resized_image = image.resize(200, 200, :ignore_aspect_ratio)
resized_image = image.resize(200, 200, :fill)

# Crop the image
cropped_image = image.crop(100, 50)

# Get the histogram
image.histogram.colors                    # => An array of Lizard::Colors
image.histogram.colors.first.red          # 23
image.histogram.colors.first.green        # 122
image.histogram.colors.first.blue         # 200

# Identify if some data is an image or not
Lizard::Image.is_image?(image_data)       #=> true/false
```
