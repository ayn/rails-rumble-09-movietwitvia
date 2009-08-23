if RUBY_VERSION < '1.9'
  $KCODE = "u"
  require "jcode"
end

#ruby core
require "open-uri"
require "erb"

#gems
require "rexml/text"
require "rubygems"
require "mechanize"
require "hpricot"

#scrubyt
require "#{File.dirname(__FILE__)}/scrubyt/logging"
require "#{File.dirname(__FILE__)}/scrubyt/utils/ruby_extensions.rb"
require "#{File.dirname(__FILE__)}/scrubyt/utils/xpathutils.rb"
require "#{File.dirname(__FILE__)}/scrubyt/utils/shared_utils.rb"
require "#{File.dirname(__FILE__)}/scrubyt/utils/simple_example_lookup.rb"
require "#{File.dirname(__FILE__)}/scrubyt/utils/compound_example_lookup.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/constraint_adder.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/constraint.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/result_indexer.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/pre_filter_document.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/compound_example.rb"
require "#{File.dirname(__FILE__)}/scrubyt/output/result_node.rb"
require "#{File.dirname(__FILE__)}/scrubyt/output/scrubyt_result.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/navigation/agents/mechanize.rb"

# -- Making Firewatir optional --
begin
  require "#{File.dirname(__FILE__)}/scrubyt/core/navigation/agents/firewatir.rb"
rescue LoadError
  puts "The gem firewatir is not installed, you'll be able to use Mechanize as the agent only"
end
# --

require "#{File.dirname(__FILE__)}/scrubyt/core/navigation/navigation_actions.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/navigation/fetch_action.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/shared/extractor.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/filters/base_filter.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/filters/attribute_filter.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/filters/constant_filter.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/filters/script_filter.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/filters/text_filter.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/filters/detail_page_filter.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/filters/download_filter.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/filters/html_subtree_filter.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/filters/regexp_filter.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/filters/tree_filter.rb"
require "#{File.dirname(__FILE__)}/scrubyt/core/scraping/pattern.rb"