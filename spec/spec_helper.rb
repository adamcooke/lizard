TEST_IMAGE_ROOT = File.expand_path('../images', __FILE__)
TEST_FILES = {
  :example => File.read(File.join(TEST_IMAGE_ROOT, 'example.jpg')),
  :broken => File.read(File.join(TEST_IMAGE_ROOT, 'broken.jpg'))
}
