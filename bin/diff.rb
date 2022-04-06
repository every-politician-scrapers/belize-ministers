#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/comparison'

diff = EveryPoliticianScraper::NulllessComparison.new('data/wikidata.csv', 'data/official.csv').diff
                                         .reject { |row| row.last.to_s.include? 'Minister of State' }
puts diff.sort_by { |r| [r.first, r[1].to_s] }.reverse.map(&:to_csv)
