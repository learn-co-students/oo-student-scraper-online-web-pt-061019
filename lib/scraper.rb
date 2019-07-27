require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    url = open(index_url)
    index_page = Nokogiri::HTML(url)
    index_page.css('div.student-card').each do |student_card|
      name = student_card.css('h4.student-name').text
      location = student_card.css('p.student-location').text
      # profile_url = student_card.css('a')[0].attributes
      hash  = {
        name: name,
        location: location
        # profile_url: profile_url
      }
      array << hash
      # binding.pry
    end
  end

  def self.scrape_profile_page(profile_url)
    binding.pry
    # url = open(profile_url)
    # binding.pry
    # profile_page = Nokogiri::HTML(url)
    # binding.pry
    # twitter_url = profile_page.css('a').text
    # binding.pry
  end

end
