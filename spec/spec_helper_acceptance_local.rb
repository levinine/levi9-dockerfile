require 'puppet_litmus'
require 'singleton'

class Helper
  include Singleton
  include PuppetLitmus
end

# frozen_string_literal: true

def setup_test_directory
  basedir = case os[:family]
            when 'windows'
              'c:/Dockerfiles'
            else
              '/tmp/Dockerfiles'
            end
  pp = <<-MANIFEST
    file { '#{basedir}':
      ensure  => directory,
      force   => true,
      purge   => true,
      recurse => true,
    }
  MANIFEST
  apply_manifest(pp)
  basedir
end
