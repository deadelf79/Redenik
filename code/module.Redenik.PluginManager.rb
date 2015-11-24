# encoding utf-8
module PluginManager
	class << self
		def enabled?
			#
		end

		def read_list
			@list = JSON.decode(open("Plugins/plugins.json","r"))
		end

		def check_for_errors
			#
		end

		def load
			@list.each{|file|
				begin
					file.gsub!(/\.plugin$/){""}
					code = open("Plugins/#{file}.plugin", "r")
					_convert(code)
				rescue
					wr "Cannot load plugin \"#{file}.plugin\"! "+
					"PluginManager will ignore this line and continue loading." 
				end
			}
		end

		private

		def _convert(code)
			@result = code.readlines.join(";")
			
			_exclude_tabs
			_exclude_comments
			_exclude_lines
			_convert_conditions
			_convert_variables
			_clean_code

			eval(@result)
		end

		def _exclude_tabs
			@result.gsub!(/\t/){""}
			@result.gsub!(/^( )+/){""}
		end

		def _exclude_comments
			@result.gsub!(/\/\/(.+)/){""}
		end

		def _exclude_lines
			@result.gsub!(/\n/){""}
		end

		def _clean_code
			@result.gsub!(/;{2,}/){";"}
			@result.gsub!(/^;/){""}
			@result.gsub!(/[\s]*(\=*)[\s]*/){"#{$1}"}
		end

		def _convert_conditions
			@result.gsub!(/[\s]*===[\s]*/){"=="}
			@result.gsub!(/if[\s]*\((.+)\)[\s]*(\{)/){"if(#{$1});"}
			@result.gsub!(/\}[\s]*else[\s]*\{/){"else;"}
			@result.gsub!(/\}/){"end"}
		end

		def _convert_variables
			@result.gsub!(/(\w[\s]*[\=\<\>][\s]*)/){"@#{$1}"}
			@result.gsub!(/@(\w[\s]*[\=\<\>][\s]*)([\w\d\'\"])*,/){"@#{$1}#{$2};"}
			@result.gsub!(/var[\s]*/){""}
		end
	end
end