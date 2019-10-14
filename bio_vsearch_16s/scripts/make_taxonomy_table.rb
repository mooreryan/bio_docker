#!/usr/bin/env ruby
Signal.trap("PIPE", "EXIT")

require "abort_if"

include AbortIf
include AbortIf::Assert

abort_unless ARGV.count == 2,
             "usage: make_taxonomy_table sintax_file out_file"

LEVEL_ORDER = %w[d p c o f g s]

# tax looks like: d:bacteria,p:firmicutes,c:clostridia,o:clostridiales,f:clostridiaceae,g:clostridium,s:disporicum.  Not all levels need be present.
def parse_tax tax
  tax_lookup = Hash.new do |ht, k|
    ht[k] = "NA"
  end

  # Empty tax string means sintax didn't get any hits.
  unless tax.empty?
    # Do this in case the taxonomy isn't in the correct order.
    tax.split(",").each do |tax_info|
      level, name = tax_info.split ":"

      abort_if tax_lookup.has_key?(level),
               "Level '#{level}' is repeated in tax string: '#{tax}'"

      tax_lookup[level] = name.capitalize
    end
  end

  # Return an array of tax names in order of LEVEL_ORDER.
  LEVEL_ORDER.map do |level|
    tax_lookup[level]
  end
end

File.open(ARGV[1], "w") do |f|

  f.puts [
    "asv",
    "Domain",
    "Phylum",
    "Class",
    "Order",
    "Family",
    "Genus",
    "Species",
  ].join "\t"

  File.open(ARGV[0], "rt").each_line.with_index do |line, idx|
    ary = line.chomp.split "\t"

    abort_unless ary.length == 1 || ary.length == 4,
                 "Expected 1 or 4 columns, got #{ary.length} in " \
                 "line #{idx + 1}"

    asv, full_tax, strand, tax = ary

    # If tax is nil then there was no prediction for this ASV.
    tax = "" if tax.nil?

    f.puts [asv, parse_tax(tax)].join "\t"
  end
end
