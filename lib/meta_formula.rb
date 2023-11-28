class MetaFormula < Formula
  def self.inherited(subclass)
    super
    subclass.instance_eval do
      url 'https://raw.githubusercontent.com/umts/homebrew-umts-dev/main/PLACEHOLDER'
      sha256 "ad25dd4ef7299917497c3ba729c2e803f53991fd070aa2a2f325a35f666c180e"
      keg_only "it's a meta-package"
    end
  end

  def install
    share.install 'PLACEHOLDER'
  end
end
