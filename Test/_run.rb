#!/usr/bin/ruby

require "Lexer"
require "Parser"

l = Lexer.new
l.yyin = File.open("input.txt", "r")

bd_parser = Parser.new
bd_parser.init_data

begin
	bd_parser.yyparse(l)
	puts "All right!"
rescue Parser::ParseError
	puts "Wrong BD format"
	exit 1
end
