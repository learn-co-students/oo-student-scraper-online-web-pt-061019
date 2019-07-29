require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_hash = [] 
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect do |student|
      hash = {
        location: student.css("p.student-location").text,
        name: student.css("h4.student-name").text,
        profile_url: student.css("a").attribute("href").value
      }
      students_hash << hash
    end 
    students_hash
  end

  def self.scrape_profile_page(profile_url)
    students_hash = {} 
    html = Nokogiri::HTML(open(profile_url))

    social_links = html.css(".social-icon-container a").collect {|icon| icon.attribute("href").value}

    social_links.each do |link|
      if link.include?("twitter")
        students_hash[:twitter] = link
      elsif link.include?("linkedin")
        students_hash[:linkedin] = link
        elsif link.include?("github")
          students_hash[:github] = link
        else 
          students_hash[:blog] = link
        end
      end
      students_hash[:profile_quote] = html.css(".profile-quote").text
      students_hash[:bio] = html.css(".description-holder p").text
      students_hash
    end 
end 
