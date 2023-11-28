cask 'umts-nodenv' do

  version '0.0.1'
  url 'https://raw.githubusercontent.com/umts/homebrew-umts-dev/main/PLACEHOLDER'
  sha256 'ad25dd4ef7299917497c3ba729c2e803f53991fd070aa2a2f325a35f666c180e'

  name 'UMTS nodenv setup'
  desc 'Installs nodenv and configures shell integrations'
  homepage 'https://github.com/umts/homebrew-umts-dev'

  stage_only true

  depends_on formula: 'nodenv'

  postflight do
    unless Utils.nodenv_is_function?
      File.open(Utils.rcfile, 'a') do |f|
        f.puts 'eval "$(nodenv init -)"'
      end
    end
  end

  module Utils
    require 'etc'
    require 'pathname'

    module_function

    def home
      Pathname(ENV['HOME'])
    end

    def nodenv_is_function?
      case shell
      when 'zsh'
        /^nodenv: function$/.match? `zsh -l -c 'whence -w nodenv'`
      when 'bash'
        /^function$/.match? `bash -l -c 'type -t nodenv'`
      else
        false
      end
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
end
