# frozen_string_literal: true

require 'utils/output'
require_relative 'shell_utils'

class BrewPathSetup
  include Utils::Output::Mixin
  include ShellUtils

  def setup!
    setup_shell!
  end

  private

  def brew_is_in_path?
    case shell
    when 'zsh'
      /^brew: command$/.match? `zsh -i -c 'whence -w brew'`
    when 'bash'
      /^file$/.match? `bash -l -c 'type -t brew'`
    else
      false
    end
  end

  def init_string
    %|eval "$(#{HOMEBREW_PREFIX.to_s.chomp}/bin/brew shellenv)"|
  end

  def setup_shell!
    return if brew_is_in_path?

    rcfile.then do |rc|
      opoo <<~MSG and return unless rc
        Don't know how to set up Homebrew for your shell (#{shell}).
        You'll need to do it yourself.

        Add the following line to your shell's startup:

        #{init_string}
      MSG

      rc.open('a') { |f| f.puts init_string }
    end
  end
end
