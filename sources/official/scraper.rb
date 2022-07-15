#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      Name.new(
        full:     noko.css('h4').text.tidy,
        prefixes: %w[Dr Hon]
      ).short
    end

    def position
      return unless role

      role.split(/[&,] (?=Minister)/).map(&:tidy)
    end

    private

    def person_extras
      noko.css('h5').text.tidy
    end

    def role
      return 'Speaker' if person_extras == 'Speaker'

      # anyone who's a Minister has that part in brackets
      person_extras[/\(([^)]+)\)/, 1]
    end
  end

  class Members
    def member_items
      super.select(&:position)
    end

    def member_container
      noko.css('.title').map(&:parent)
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
