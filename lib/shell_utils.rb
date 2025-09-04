# frozen_string_literal: true

require 'etc'
require 'pathname'

module ShellUtils
  def home
    @home ||= Pathname(Dir.home)
  end

  def rcfile
    case shell
    when 'zsh' then home.join('.zshrc')
    when 'bash' then home.join('.bash_profile')
    else File::NULL
    end
  end

  def shell
    @shell ||= Etc.getpwuid.shell.split('/').last
  end
end
