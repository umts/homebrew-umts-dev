# frozen_string_literal: true

require 'utils/output'
require_relative 'shell_utils'

class NodenvSetup
  include Utils::Output::Mixin
  include ShellUtils

  def setup!
    setup_shell!
  end

  private

  def init_string
    'eval "$(nodenv init -)"'
  end

  def nodenv_is_a_function?
    case shell
    when 'zsh'
      /^nodenv: function$/.match? `zsh -i -c 'whence -w nodenv'`
    when 'bash'
      /^function$/.match? `bash -l -c 'type -t nodenv'`
    else
      false
    end
  end

  def setup_shell!
    return if nodenv_is_a_function?

    rcfile.then do |rc|
      opoo <<~MSG and return unless rc
        Don't know how to set up nodenv for your shell (#{shell}).
        You'll need to do it yourself.

        Add the following line to your shell's startup:

        #{init_string}
      MSG

      rc.open('a') { |f| f.puts init_string }
    end
  end
end
