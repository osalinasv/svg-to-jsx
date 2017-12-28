#!/usr/local/bin/ruby -w

begin
	require "fileutils"
	require "optparse"
	require "nokogiri"
	require "nokogiri-pretty"
rescue Gem::LoadError
	raise `This tool required the following gems:
	fileutils
	optparse
	nokogiri
	nokogiri-pretty`
end

# Main program

class Main
	EXT = ".svg"

	def initialize()
		@source_path = ""
		@output_path = ""
		
		@options = {
			resursive: false,
			pure: false
		}
	end

	def run
		exit! if !option_parser()

		source_path_exists = FileHelper.directory_exists?(@source_path)
	
		raise "\nSource directory not found or does not exists" unless source_path_exists
		
		unless FileHelper.directory_exists?(@output_path)
			FileUtils.mkdir_p(@output_path)
		end
		
		output_path_exists = FileHelper.directory_exists?(@output_path)
		
		raise "\nOutput directory does not exist or could not be created due to permission errors" unless output_path_exists
		
		files_array = FileHelper.list_all_files_in_dir(@source_path, @options[:recursive], EXT)
		
		puts "\nFiles found: #{files_array.length}\n\n"
		
		process_all_files(files_array)
	end

	def option_parser
		ARGV << "-h" if ARGV.empty?

		op = OptionParser.new do |parser|
			parser.banner = "Usage: svg-to-jsx.rb <source_path> <output_path> [options]"
		
			parser.on("-r", "--[no-]recursive", "Whether to search for files inside subfolders or not. (False by default)") do |value|
				@options[:recursive] = true
			end
		
			parser.on("-p", "--[non-]pure", "Export as JSX pure functional components using recompose. (False by default)") do |value|
				@options[:pure] = true
			end
		
			parser.on("-h", "--help", "Show this help message") do ||
				puts "\n #{parser}"
				exit!
			end
		end
		
		op.parse!

		@source_path = FileHelper.parse_directory_argument(ARGV[0])
		@output_path = FileHelper.parse_directory_argument(ARGV[1])
		
		raise "\nNo source path input" unless @source_path
		raise "\nNo output path input" unless @output_path

		return true
	end

	def process_all_files(files_array)
		file_name = ''
		capitalized_name = ''
		full_path = ''
		
		files_array.each do |file_path|
			file_name = FileHelper.get_file_name(file_path, EXT)
			capitalized_name = SVGtoJSX.string_to_CamelCase(file_name) + "Icon";
		
			full_path = "#{@output_path}/#{capitalized_name}.js"
		
			write_jsx_file(file_path, full_path, capitalized_name, @options[:pure])
		end
	end

	def write_jsx_file(file_path, full_path, capitalized_name, pure)
		svg_file_path = FileHelper.parse_directory_argument(file_path)
		new_file_path = FileHelper.parse_directory_argument(full_path)
	
		if FileHelper.file_exists?(new_file_path)
			File.delete(new_file_path)
		end
	
		new_file = File.open(new_file_path, "w")
	
		puts "Created new file: #{capitalized_name}.js"
		content = XMLFormatter.process_xml_file(svg_file_path)
	
		jsx = SVGtoJSX.parse_to_jsx_component(capitalized_name, content, pure)
	
		new_file.write(jsx)
		new_file.close()
	end
end

# Methods

class FileHelper
	def self.parse_directory_argument(arg)
		File.expand_path(arg)
	end
	
	def self.directory_exists?(path)
		File.directory?(File.expand_path(path))
	end
	
	def self.file_exists?(path)
		File.exist?(File.expand_path(path))
	end
	
	def self.get_file_name(file_path, ext = "")
		File.basename(File.expand_path(file_path), ext)
	end
	
	def self.list_all_files_in_dir(path, recursive = false, ext = "")
		full_path = "#{File.expand_path(path)}"
	
		if recursive
			full_path << "/**"
		end
	
		full_path << "/*#{ext}"
	
		return Dir[full_path]
	end
end

class XMLFormatter
	def self.read_file_content(file_path)
		if !FileHelper.file_exists?(file_path)
			return ""
		end
		
		content = ""
	
		File.foreach(file_path) do |line|
			content << line
		end
	
		return content
	end

	def self.strip_xml_header(content)
		content.sub(/<\?xml(.)+>/, "")
	end

	def self.process_xml_file(file_path)
		content = read_file_content(file_path)
		content.encode("UTF-8")
	
		input_content = Nokogiri::XML::DocumentFragment.parse content
		parsed_content = input_content.to_xml
	
		xml = Nokogiri::XML parsed_content
		pretty = xml.human
	
		output = strip_xml_header(pretty).strip().gsub!("  ", "\t")
	
		return output
	end
end

class SVGtoJSX
	TEMPLATE_REACT = "import React from 'react';\n"
	TEMPLATE_RECOMPOSE = "import { pure } from 'recompose';\n"

	TEMPLATE = <<-JSX

import "./Icon.css";

const %{name} = ({ ...props }) => (
	<div className="Icon">
%{content}
	</div>
);
JSX

	def self.string_to_CamelCase(string)
		final = ""

		if string.include?("_")
			final = string.split("_").collect(&:capitalize).join
		elsif string.include?("-")
			final = string.split("-").collect(&:capitalize).join
		else
			final = string.capitalize
		end

		return final
	end

	def self.parse_to_jsx_component(name, content, pure)
		tabbed_content = ""

		content.each_line do |line|
			tabbed_content << line.prepend("\t\t")
		end

		jsx_template = ""
		jsx_template << TEMPLATE_REACT

		if pure
			jsx_template << TEMPLATE_RECOMPOSE
		end

		jsx_template << TEMPLATE % { name: name, content: tabbed_content }

		if pure
			jsx_template << "\nconst Pure#{name} = pure(#{name});\n"
			jsx_template << "\nexport default Pure#{name};\n"
		else
			jsx_template << "\nexport default #{name};\n"
		end

		return jsx_template
	end
end

# Main program execution

main = Main.new()
main.run()
