require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    #binding.pry
    
    scraped_students = []
    
    students = doc.css(".student-card a")
    students.each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      hash = {:name => name,
      :location => location,
      :profile_url => profile_url
    }
    scraped_students << hash
  end
    scraped_students
    
    
      
#       scrapedStudents= []   ``````make empty array
#       students = doc.css("div .roster-cards-container")
#       students.each do |student|
#         ```scrape  the desired texts and make them into a hash
#         ```push the hash into scrapedStudents
#     end
#     return scrapedStudents
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

