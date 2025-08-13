# frozen_string_literal: true

require_relative 'shell_utils'

class BrewPathSetup
  include ShellUtils

  def self.setup!
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

  def setup_shell!
    return if brew_is_in_path?

    rcfile.open('a') do |f|
      f.puts %|eval "$(#{`brew --prefix`}/bin/brew shellenv)"|
    end
  end
end
