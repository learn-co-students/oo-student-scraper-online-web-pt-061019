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

  end

end
#
# Scraper.new.scrape_index_page
