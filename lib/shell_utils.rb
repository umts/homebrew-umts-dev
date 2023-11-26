require 'etc'
require 'pathname'

module ShellUtils
  def home
    Pathname(ENV['HOME'])
  end

  def rcfile
    case shell
    when 'zsh' then home.join('.zshrc')
    when 'bash' then home.join('.bash_profile')
    else '/dev/null'
    end
  end

  def shell
    Etc.getpwuid.shell.split('/').last
  end
end
