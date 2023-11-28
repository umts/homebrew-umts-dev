require_relative '../lib/nodenv_setup'
require_relative '../lib/rbenv_setup'

module Homebrew
  module_function

  def umts_dev_setup
    setup_nodenv
    setup_rbenv
    puts "\e[92mYou will need to restart your shell for some changes to take effect.\e[0m"
  end

  def setup_nodenv
    NodenvSetup.new.setup!
  end

  def setup_rbenv
    RbenvSetup.new.setup!
  end
end
