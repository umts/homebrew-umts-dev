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
    unless Utils.rbenv_is_function?
      File.open(Utils.rcfile, 'w+') do |f|
        f.puts %Q|eval "$(rbenv init - #{Utils.shell})"|
      end
    end

    version = Utils.ruby_version
    global_file = Utils.home.join '.rbenv', 'version'
    unless global_file.exist?
      global_file.write "#{version}\n"
    end

    system 'rbenv', 'install', '--skip-existing', version
  end

  module Utils
    require 'etc'
    require 'pathname'
    require 'rubygems'

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

    def ruby_version
      versions = `sh -l -c 'rbenv install --list'`.split.select { |v| /^[0-9.]+$/.match? v }
      versions.max_by { |v| Gem::Version.new(v) }
    end

    def shell
      Etc.getpwuid.shell.split('/').last
    end
  end
end
