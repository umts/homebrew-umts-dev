# frozen_string_literal: true

require 'etc'
require 'pathname'
require 'utils/output'

module ShellUtils
  include Utils::Output::Mixin

  def append_to_rcfile(line)
    rcfile.then do |rc|
      opoo <<~MSG and next unless rc
        Don't know how to set up your shell (#{shell}).
        You'll need to do it yourself.

        Add the following line to your shell's startup:

        #{line}
      MSG

      rc.open('a') { |f| f.puts line }
    end
  end

  def home
    @home ||= Pathname(Dir.home)
  end

  def rcfile
    case shell
    when 'zsh' then home.join('.zshrc')
    when 'bash' then home.join('.bash_profile')
    end
  end

  def shell
    @shell ||= Etc.getpwuid.shell.split('/').last
  end
end
