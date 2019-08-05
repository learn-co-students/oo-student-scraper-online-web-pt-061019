require 'open-uri'
require 'pry'

class Scraper
  INDEX_URL = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"

  def self.scrape_index_page(index_url = INDEX_URL)
    page = open(index_url)
    doc = Nokogiri::HTML(page)
    student_cards = doc.css(".student-card")
    student_cards.map {|card|
      student = {}
      student[name] = card.css(".student-name").text.strip
      student[location] = card.css(".student-location").text.strip
      student[profile_url] = card.css("a")[0]["href"]
      student
  }
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

