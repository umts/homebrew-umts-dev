require 'etc'
require 'pathname'
require_relative '../lib/meta_formula'

class RbenvUmts < MetaFormula
  desc 'Installs Rbenv, but also handles the shell initialization'
  homepage 'https://github.com/umts/homebrew-umts-dev'
  license 'MIT'
  version '0.0.3'

  depends_on 'rbenv'

  def post_install
    return if rbenv_is_function?

    File.open(rcfile, 'w+') do |f|
      f.puts %Q|eval "$(rbenv init - #{shell})"|
    end
  end

  private

  def rcfile
    case shell
    when 'zsh' then zshrc
    when 'bash' then bash_profile
    end
  end

  def bash_profile
    @bash_profile ||= home.join('.bash_profile')
  end

  def zshrc
    @zshrc ||= home.join('.zshrc')
  end

  def home
    Pathname(ENV['HOME'])
  end

  def rbenv_is_function?
    case shell
    when 'zsh'
      !!(`zsh -l -c 'whence -w rbenv'` =~ /^rbenv: function$/)
    when 'bash'
      !!(`bash -l -c 'type -t rbenv'` =~ /^function$/)
    end
  end

  def shell
    @shell ||= Etc.getpwuid.shell.split('/').last
  end
end
