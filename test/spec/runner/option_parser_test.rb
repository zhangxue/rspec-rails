require File.dirname(__FILE__) + '/../../test_helper'

module Spec
  module Runner
    class OptionParserTest < Test::Unit::TestCase

      def setup
        @out = StringIO.new
        @err = StringIO.new
      end

      def test_should_print_version_to_stdout
        options = OptionParser.parse(["--version"], false, @err, @out)
        @out.rewind
        assert_match(/RSpec-\d+\.\d+\.\d+ - BDD for Ruby\nhttp:\/\/rspec.rubyforge.org\/\n/n, @out.read)
      end

      def test_should_print_help_to_stdout
        options = OptionParser.parse(["--help"], false, @err, @out)
        @out.rewind
        assert_match(/Usage: spec \[options\] \(FILE\|DIRECTORY\)\+/n, @out.read)
      end
      
      def test_verbose_should_be_false_by_default
        options = OptionParser.parse([], false, @err, @out)
        assert(!options.verbose)
      end

      def test_verbose_should_be_settable
        options = OptionParser.parse(["--verbose"], false, @err, @out)
        assert(options.verbose)
      end

      def test_dry_run_should_be_settable
        options = OptionParser.parse(["--dry-run"], false, @err, @out)
        assert(options.dry_run)
      end

      def test_should_use_specdoc_formatter_by_default
        options = OptionParser.parse([], false, @err, @out)
        assert_equal(SpecdocFormatter, options.formatter_type)
      end
      
      def test_should_use_specdoc_formatter_when_format_is_specdoc
        options = OptionParser.parse(["--formatter=specdoc"], false, @err, @out)
        assert_equal(SpecdocFormatter, options.formatter_type)
      end

      def test_should_use_rdoc_formatter_when_format_is_rdoc
        options = OptionParser.parse(["--formatter=rdoc"], false, @err, @out)
        assert_equal(RdocFormatter, options.formatter_type)
      end
      
      def test_should_print_usage_to_err_if_no_dir_specified
        options = OptionParser.parse([], false, @err, @out)
        assert_match(/Usage: spec/, @err.string)
      end
      
      def test_backtrace_tweaker_should_be_quiet_by_default
        options = OptionParser.parse([], false, @err, @out)
        assert options.backtrace_tweaker.instance_of?(QuietBacktraceTweaker)
      end
      
      def test_backtrace_tweaker_should_be_noisy_with_b
        options = OptionParser.parse(["-b"], false, @err, @out)
        assert options.backtrace_tweaker.instance_of?(NoisyBacktraceTweaker)
      end
      
      def test_backtrace_tweaker_should_be_noisy_with_backtrace
        options = OptionParser.parse(["--backtrace"], false, @err, @out)
        assert options.backtrace_tweaker.instance_of?(NoisyBacktraceTweaker)
      end
    end
  end
end
