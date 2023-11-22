cask 'umts-rbenv' do
  version '0.0.1'
  sha256 'ad25dd4ef7299917497c3ba729c2e803f53991fd070aa2a2f325a35f666c180e'
  url 'https://raw.githubusercontent.com/umts/homebrew-umts-dev/main/PLACEHOLDER'

  name 'UMTS rbenv setup'
  desc 'Installs rbenv and configures shell integrations'
  homepage 'https://github.com/umts/homebrew-umts-dev'

  stage_only true

  depends_on formula: 'rbenv'
end
