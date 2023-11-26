cask 'umts-dev' do
  version '0.0.1'

  url 'https://raw.githubusercontent.com/umts/homebrew-umts-dev/main/PLACEHOLDER'
  sha256 'ad25dd4ef7299917497c3ba729c2e803f53991fd070aa2a2f325a35f666c180e'

  name 'UMTS developer setup'
  desc 'Installs developer tools, sets up their shell'
  homepage 'https://github.com/umts/homebrew-umts-dev'

  stage_only true

  depends_on cask: 'umts-nodenv'
  depends_on cask: 'umts-rbenv'
end
