require 'etc'
require 'pathname'

module ShellUtils
  def home
    @home ||= Pathname(ENV['HOME'])
  end

  def rcfile
    case shell
    when 'zsh' then home.join('.zshrc')
    when 'bash' then home.join('.bash_profile')
    else Pathname(File::NULL)
    end
  end

  def shell
    @shell ||= Etc.getpwuid.shell.split('/').last
  end
end
