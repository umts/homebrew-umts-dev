cask 'umts-rbenv' do
  version '0.0.1'
  sha256 'ad25dd4ef7299917497c3ba729c2e803f53991fd070aa2a2f325a35f666c180e'
  url 'https://raw.githubusercontent.com/umts/homebrew-umts-dev/main/PLACEHOLDER'

  name 'UMTS rbenv setup'
  desc 'Installs rbenv and configures shell integrations'
  homepage 'https://github.com/umts/homebrew-umts-dev'

  stage_only true

  depends_on formula: 'rbenv'

  postflight do
    next if Utils.rbenv_is_function?

    File.open(Utils.rcfile, 'w+') do |f|
      f.puts %Q|eval "$(rbenv init - #{Utils.shell})"|
    end
  end

  module Utils
    require 'etc'
    require 'pathname'

    module_function

    def home
      Pathname(ENV['HOME'])
    end

    def rbenv_is_function?
      case shell
      when 'zsh'
        /^rbenv: function$/.match? `zsh -l -c 'whence -w rbenv'`
      when 'bash'
        /^function$/.match? `bash -l -c 'type -t rbenv'`
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
