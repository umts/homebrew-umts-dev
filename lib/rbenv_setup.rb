# frozen_string_literal: true

require 'rubygems'
require 'utils/output'
require_relative 'shell_utils'

class RbenvSetup
  include Utils::Output::Mixin
  include ShellUtils

  def setup!
    setup_shell!
    install_ruby!
    global_version!
    update_gems!
  end

  private

  def global_version!
    home.join('.rbenv', 'version').then do |gf|
      gf.dirname.mkdir unless gf.dirname.exist?
      gf.write "#{ruby_version}\n" unless gf.exist?
    end
  end

  def init_string
    %|eval "$(rbenv init - #{shell})"|
  end

  def install_ruby!
    rbenv "install --skip-existing #{ruby_version}"
    rbenv 'rehash'
  end

  def ruby_version
    @ruby_version ||= rbenv('install --list').split.grep(/^[0-9.]+$/).max_by do |v|
      Gem::Version.new(v)
    end
  end

  def rbenv(command)
    paths = ENV.fetch('PATH', '').split(':').unshift(HOMEBREW_PREFIX.join('bin').to_s).uniq
    IO.popen({ 'PATH' => paths.join(':') }, "#{shell} -i -c 'rbenv #{command}'") do |io|
      io.read.strip
    end
  end

  def rbenv_is_a_function?
    case shell
    when 'zsh'
      /^rbenv: function$/.match? `zsh -i -c 'whence -w rbenv'`
    when 'bash'
      /^function$/.match? `bash -l -c 'type -t rbenv'`
    else
      false
    end
  end

  def setup_shell!
    return if rbenv_is_a_function?

    rcfile.then do |rc|
      opoo <<~MSG and return unless rc
        Don't know how to set up rbenv for your shell (#{shell}).
        You'll need to do it yourself.

        Add the following line to your shell's startup:

        #{init_string}
      MSG

      rc.open('a') { |f| f.puts init_string }
    end
  end

  def update_gems!
    rbenv 'exec gem update --silent --system'
  end
end
