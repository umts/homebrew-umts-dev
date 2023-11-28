require_relative 'shell_utils'

class NodenvSetup
  include ShellUtils

  def setup!
    setup_shell!
  end

  private

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
    unless nodenv_is_a_function?
      rcfile.open('a') do |f|
        f.puts 'eval "$(nodenv init -)"'
      end
    end
  end
end
