# frozen_string_literal: true

require 'execjs'
require 'katex'

# Provides a Ruby wrapper for pseudocode server-side rendering.
module Pseudocode
  # Version of this gem
  VERSION = '0.1.0'
  # Version of the included Pseudocode.js
  PSEUDOCODE_VERSION = '2.2.0'

  # JavaScript runtime and context
  @load_context_mutex = Mutex.new
  @context = nil
  @execjs_runtime = -> { ExecJS.runtime }

  # Autoincrementing caption counter
  @caption_count = 0

  class << self
    # Renders the given pseudocode algorithm to HTML via pseudocode.renderToString.
    #
    # @param algorithm [String] The algorithm expression
    # @param line_number [Bool] Whether to include line numbers
    # @param options [Hash] Additional options for pseudocode.renderToString.
    #
    # @return [String, Int] HTML render and caption number
    #
    # @note This method is thread-safe as long as your ExecJS runtime is
    #   thread-safe. MiniRacer is the recommended runtime.
    def render(algorithm, line_number: false, **options)
      return pseudocode_context.call('pseudocode.renderToString', algorithm,
                                     lineNumber: line_number,
                                     captionCount: @caption_count,
                                     **options), @caption_count += 1
    rescue ExecJS::ProgramError => e
      raise e
    end

    # The ExecJS runtime factory, default: `-> { ExecJS.runtime }`.
    # Set this before calling any other methods to use a different runtime.
    #
    # This proc is guaranteed to be called at most once.
    attr_accessor :execjs_runtime

    # Emulated caption counter to allow manipulation from ruby
    attr_accessor :caption_count

    # Return JS context, preloaded with KaTeX and Pseudocode.js
    def pseudocode_context
      @load_context_mutex.synchronize do
        source = (File.read Katex.katex_js_path) + (File.read pseudocode_js_path)
        @context ||= @execjs_runtime.call.compile source
      end
    end

    # Return path to included Pseudocode.js script file
    def pseudocode_js_path
      File.expand_path File.join('vendor', 'pseudocode', 'pseudocode.min.js'),
                       gem_path
    end

    # Return path to included Pseudocode.js style file
    def pseudocode_css_path
      File.expand_path File.join('vendor', 'pseudocode', 'pseudocode.min.css'),
                       gem_path
    end

    # Return gem base path
    def gem_path
      @gem_path ||=
        File.expand_path(File.join(File.dirname(__FILE__), '..'))
    end
  end
end
