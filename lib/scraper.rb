require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

attr_accessor :name, :location, :profile_url, :twitter, :linkedin, :github, :blog, :profile_quote, :bio

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
    new_array = []
    doc = Nokogiri::HTML(open(profile_url))
    all_urls = doc.css(".social-icon-container").css("a")
    list_of_urls = all_urls.collect do |page|
      page['href']
    end
    twitter_page = list_of_urls.find do |pages|
      pages.include?("twitter")
    end
    linkedin_page = list_of_urls.find do |pages|
      pages.include?("linkedin")
    end
    github_page = list_of_urls.find do |pages|
      pages.include?("github")
    end
    blog_page = list_of_urls.find do |pages|
      pages.include?(name) == true
      #pages
    #  end
    #end
    #quotes = doc.css("div.profile-quote").css
    #binding.pry
    #student_quote = quotes.collect do |quote|
  #    quote.text
  #  end
  #  binding.pry

end
  end

end
end
