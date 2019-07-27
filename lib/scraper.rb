require 'open-uri'
require 'pry'
require "nokogiri"
class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |student|
      students << {:name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").value}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    profile_page = {}
    page.css("div.social-icon-container a").each do |link|
      if link["href"].include?("twitter")
        profile_page[:twitter] = link["href"]
      elsif link["href"].include?("linkedin")
        profile_page[:linkedin] = link["href"]
      elsif link["href"].include?("github")
        profile_page[:github] = link["href"]
      else
        profile_page[:blog] = link["href"]
      end
    end
    profile_page
    binding.pry
  end

end

