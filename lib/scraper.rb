require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML (open(index_url))

    students = []

    #  doc.css(".profile-name").first.text
    #  doc.css(".profile-location").first.text
    #  student_card = doc.css(".profile-card").first
    #  href = student_card.css("a").first["href"]
    # hrefs = doc.css(".profile-card a").map { |anchor| anchor["href"] }

    doc.css(".student-card").each do |i|
      student = {}
      student[:name] = i.css(".student-name").text
      student[:location] =i.css(".student-location").text
      student[:profile_url] = i.css("a").attribute("href").value  #.first[#href]
      students<< student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML (open(profile_url))
    profile = {}

    doc.css(".social-icon-container a").each do |i|
      if i.attribute("href").value.include?("twitter")
        profile[:twitter] = i.attribute("href").value
      elsif i.attribute("href").value.include?("linkedin")
        profile[:linkedin] = i.attribute("href").value
      elsif i.attribute("href").value.include?("github")
        profile[:github] = i.attribute("href").value
      else
        profile[:blog] = i.attribute("href").value
      end
    end
    profile[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    profile[:bio] = doc.css(".details-container .description-holder p").text

    profile

      # hrefs = doc.css(".social-icon-container a").map { |anchor| anchor["href"]}
      # hrefs = i.css(".social-icon-container a").map { |anchor| anchor["href"]}
      # profile[:twitter] = hrefs[0] if hrefs[0].include?("twitter")?
      # profile[:linkedin] = hrefs[1]
      # profile[:github] = hrefs[2]
      # profile[:blog] = hrefs[3]
      # profile[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
      # # profile[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text.gsub("\"","")
      # profile[:bio] = doc.css(".details-container .description-holder p").text

    end
end
