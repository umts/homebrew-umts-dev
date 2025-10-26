# frozen_string_literal: true

# rubocop:disable Layout/LeadingCommentSpace
#: Sets up the developer tools installed by the `umts-dev` formula.
#:
#: This command takes care of setting up your shell with Rbenv and Nodenv
#: integration as well as installing a modern version of Ruby and setting
#: that version as a default.
# rubocop:enable Layout/LeadingCommentSpace

require_relative '../lib/nodenv_setup'
require_relative '../lib/rbenv_setup'
require_relative '../lib/brew_path_setup'

module Homebrew
  module_function

  def umts_dev_setup
    BrewPathSetup.setup!
    NodenvSetup.setup!
    RbenvSetup.setup!
    puts "\e[92mYou will need to restart your shell for some changes to take effect.\e[0m"
  end
end
