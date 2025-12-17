# frozen_string_literal: true

cask 'umts-dev' do
  version '0.0.1'

  url 'https://raw.githubusercontent.com/umts/homebrew-umts-dev/main/PLACEHOLDER'
  sha256 'ad25dd4ef7299917497c3ba729c2e803f53991fd070aa2a2f325a35f666c180e'

  name 'UMTS developer setup'
  desc 'Installs developer tools, sets up their shell'
  homepage 'https://github.com/umts/homebrew-umts-dev'

  stage_only true

  # version managers
  depends_on formula: 'nodenv'
  depends_on formula: 'rbenv'

  # ruby dependencies
  depends_on formula: 'libyaml'
  depends_on formula: 'openssl'
  depends_on formula: 'readline'

  # rails dependencies
  depends_on formula: 'mysql'
  depends_on formula: 'imagemagick'
  depends_on formula: 'vips'

  postflight do
    with_homebrew_path do
      safe_system 'brew', 'umts-dev-setup'
    end
  end
end
