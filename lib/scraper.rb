require 'open-uri'
require 'pry'

class Scraper
  BASE_URL = "https://learn-co-curriculum.github.io/student-scraper-test-page/"

  def self.scrape_index_page(index_url = BASE_URL + "index.html")
    page = open(index_url)
    doc = Nokogiri::HTML(page)
    student_cards = doc.css(".student-card")
    student_cards.map {|card|
      student = {}
      student[:name] = card.css(".student-name").text.strip
      student[:location] = card.css(".student-location").text.strip
      student[:profile_url] = card.css("a")[0]["href"]
      student
    }
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    links = doc.css(".social-icon-container").children.css("a").map {|link| link["href"] }
    links.each {|link|
      if link.include?("twitter") 
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    }
    student[:profile_quote] = doc.css(".profile-quote").text.strip
    student[:bio] = doc.css(".bio-block.details-block .description-holder p").text
    # binding.pry
  end

end

