require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    students = doc.css('.student-card').map do |s|
      {
        :name => s.css(".student-name").text,
        :location => s.css(".student-location").text,
        :profile_url => s.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    doc = Nokogiri::HTML(open(profile_url))

    social_links = doc.css(".social-icon-container a").map {|l| l["href"]}

    social_links.each do |l|
      student_profile[:twitter] = l if l.include?("twitter")
      student_profile[:linkedin] = l if l.include?("linkedin")
      student_profile[:github] = l if l.include?("github")
      student_profile[:blog] = l if !l.include?("twitter") && !l.include?("linkedin") && !l.include?("github")
    end

    student_profile[:bio] = doc.css('.description-holder p').text
    student_profile[:profile_quote] = doc.css('.profile-quote').text
    student_profile
  end

end
