# frozen_string_literal: true

require "jekyll"
require "fileutils"
require "tempfile"
require "addressable"
require "typhoeus"

$LOAD_PATH.unshift(File.dirname(__FILE__))

module Jekyll
  module RemoteTheme
    autoload :Downloader,  "jekyll-remote-theme/downloader"
    autoload :Executor,    "jekyll-remote-theme/executor"
    autoload :MockGemspec, "jekyll-remote-theme/mock_gemspec"
    autoload :Munger,      "jekyll-remote-theme/munger"
    autoload :Theme,       "jekyll-remote-theme/theme"
    autoload :VERSION,     "jekyll-remote-theme/version"

    CONFIG_KEY = "remote_theme".freeze
    LOG_KEY    = "Remote Theme:".freeze

    def self.init(site)
      Munger.new(site).munge!
    end
  end
end

Jekyll::Hooks.register :site, :after_reset do |site|
  Jekyll::RemoteTheme.init(site)
end

Ethon.logger = Jekyll.logger.writer
