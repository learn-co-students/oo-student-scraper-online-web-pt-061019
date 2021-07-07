require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    array = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css("h4.student-name")
    student_name = students.collect do |student|
      student.text
    end
    cities = doc.css(".student-location")
    student_city = cities.collect do |city|
      city.text
    end
    urls = doc.css(".student-card").css("a")
    student_profile = urls.collect do |url|
      url['href']
    end
    i = 0
    until i >= student_name.length.to_i
      array << hash = {:name=> student_name[i], :location => student_city[i], :profile_url => student_profile[i]}
      i += 1
    end
    return array
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    twitter_page = nil
    linkedin_page = nil
    github_page = nil
    blog_page = nil
    profile_quote = nil
    bio = nil
    doc = Nokogiri::HTML(open(profile_url))
    all_urls = doc.css(".social-icon-container").css("a")
    list_of_urls = all_urls.collect do |page|
      page['href']
    end
    list_of_urls.each do |pages|
      if pages.include?("twitter")
        twitter_page = pages
        hash[:twitter] = twitter_page
    elsif
      pages.include?("linkedin")
      linkedin_page = pages
      hash[:linkedin] = linkedin_page
    elsif
      pages.include?("github")
      github_page = pages
      hash[:github] = github_page
    elsif
      blog_page = pages
      hash[:blog] = blog_page
    end
    end
    profile_quote = doc.css(".profile-quote").text
    bio = doc.css(".description-holder").css("p").text
    hash[:profile_quote] = profile_quote
    hash[:bio] = bio
    return hash
  end

end
