require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css('div.student-card a').each do |student_card|
      name = student_card.css('h4.student-name').text
      location = student_card.css('p.student-location').text
      profile_url = student_card.attr('href')
      hash  = {
        name: name,
        location: location,
        profile_url: profile_url
      }
      scraped_students << hash
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profile_hash = {}
    url = open(profile_url)
    profile_page = Nokogiri::HTML(url)
    data = profile_page.css('div.social-icon-container a').each do |social|
      url = social.attr('href')
      url_array = url.split(".")
      if url_array[0] == "https://github"
        profile_hash[:github] = url
      elsif url_array[0] == "https://twitter"
        profile_hash[:twitter] = url
      elsif url_array[1] == "linkedin"
        profile_hash[:linkedin] = url
      else
        profile_hash[:blog] = url
      end
    end
    profile_hash[:profile_quote] = profile_page.css('div.profile-quote').text
    profile_hash[:bio] = profile_page.css('div.description-holder p').text
    profile_hash
  end

end
