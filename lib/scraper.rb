require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []

    doc = Nokogiri::HTML(open(index_url))
    doc.css(".roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_profile = student.css("a").attribute("href").text

    students << {:name => student_name,
                 :location => student_location,
                 :profile_url => student_profile
               }
        # binding.pry
      end
    end
      students
  end

  def self.scrape_profile_page(profile_url)
    student = {}

    profile = Nokogiri::HTML(open(profile_url))
    profile.css(".social-icon-container a").each do |social_icon|
      soc_link = social_icon.attribute("href").value
      if soc_link.include?("twitter")
        student[:twitter] = soc_link
      elsif soc_link.include?("linkedin")
        student[:linkedin] = soc_link
      elsif soc_link.include?("github")
        student[:github] = soc_link
      else
        student[:blog] = soc_link
      end
    student[:profile_quote] = profile.css(".div.profile-quote").text
    student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text
    end
  end

end

# Scraper.new.scrape_index_page
