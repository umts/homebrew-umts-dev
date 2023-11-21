require_relative '../lib/meta_formula'

class RbenvUmts < MetaFormula
  desc 'Installs Rbenv, but also handles the shell initialization'
  homepage 'https://github.com/umts/homebrew-umts-dev'
  license 'MIT'
  version '0.0.3'

  depends_on 'rbenv'
end
