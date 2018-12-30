#!/usr/bin/env ruby
# coding: utf-8
require 'io/console'
require "csv"

output_array = []
freq_list = CSV.read("./src/freq.tsv", { :col_sep => "\t" })
prompt="$:"
interactive_mode =  ARGV.include?("--i") ? true : false
freq_mode =  ARGV.include?("--f") ? true : false

print prompt

STDIN.each do |line|
  if line.strip() == "exit" then
    break
  end

  puts "Please wait a second..."
  thrax_output=`./src/bin/runCheck.sh #{line}`
  answers_array = thrax_output.scan(/: ([\wąćężźłóśń]+) </).map.with_index(1).to_a

  if(freq_mode) then
    answers_array = answers_array
                      .map{ |x| [x[0],freq_list.index(x[0])] }
                      .select{ |x| !x[1].nil? }
                      .sort_by(&:last)
                      .map{ |x| x[0] }
                      .flatten(1).map.with_index(1).to_a
                      .map{ |x| [[x[0]],x[1]] }
  end

  answers_hash = Hash[answers_array.collect { |v| [v[1], v[0]] }]

  if(answers_array.length > 0) then

    if interactive_mode then
      choosen_answer = answers_hash[1].join()
      output_array.push([line.strip(), choosen_answer])
      puts choosen_answer
    else
      puts "Possible answers:"
      answers_hash.map{ |x| puts x.to_a.join('.')}
      input_id_answer = STDIN.getch
      puts "\n"
      output_array.push([line.strip(), answers_hash[input_id_answer.to_i].join()])
    end

  else
    puts "There are no answers"
  end

  print prompt
end

puts "Your answers:"
output_array.map{ |x| puts "In: #{x[0]}: Out #{x[1]}" }
