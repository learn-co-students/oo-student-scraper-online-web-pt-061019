require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_site = Nokogiri::HTML(open(index_url))
    students = []

    index_site.css("div.student-card a").each do |student|

      location = student.css("div p.student-location").text
      name = student.css("div h4.student-name").text
      url =student.attribute("href").value
      info = {:location => location, :name => name, :profile_url => url}
      students << info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    info = {}

    profile = doc.css(".vitals-container .social-icon-container a")
    profile.each do |social|
      if social.attr('href').include?("twitter")
        info[:twitter] = social.attr('href')
      elsif social.attr('href').include?("linkedin")
        info[:linkedin] = social.attr('href')
      elsif social.attr('href').include?("github")
        info[:github] = social.attr('href')
      elsif social.attr('href').end_with?("com/")
        info[:blog] = social.attr('href')
      end
    end
    info[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
    info[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text

  info
  end
end
