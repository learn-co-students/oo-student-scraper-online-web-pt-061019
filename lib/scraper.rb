require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
      doc = Nokogiri::HTML(open(index_url))
      student_list = []
      doc.css("div.student-card").each do |students|
      name = students.css("h4.student-name").text
      location = students.css("p.student-location").text
      profile_url = students.css("a").attribute("href").value
      student = {name: name, location: location, profile_url: profile_url}
      student_list << student
    end
    student_list
  end


  def self.scrape_profile_page(profile_url)
      doc = Nokogiri::HTML(open(profile_url))
      student = {}

      social_container = doc.css("div.social-icon-container a").collect {|icon_c| icon_c.attribute("href").value}

      social_container.each do |links|
        if links.include?("twitter")
          student[:twitter] = links
        elsif links.include?("linkedin")
          student[:linkedin] = links
        elsif links.include?("github")
          student[:github] = links
        else student[:blog] = links
        end
      end
          student[:bio] = doc.css("div.description-holder p").text
          student[:profile_quote] = doc.css("div.profile-quote").text
          student
  end
end
