require_relative '../lib/meta_formula'

class UmtsDev < MetaFormula
  desc 'Installs command-line tools as a base for UMTS developers'

  homepage 'https://github.com/umts/homebrew-umts-dev'
  license 'MIT'
  version '0.0.5'

  depends_on 'nodenv'
  depends_on 'rbenv'
end
