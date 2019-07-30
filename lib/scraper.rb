require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)    
    index_url ="./fixtures/student-site/index.html"
    
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css('div.student-card')
    
    students.map do |student|
        {:name => student.css('h4.student-name').text.strip,
         :location => student.css('p.student-location').text.strip,
         :profile_url => student.css('a').first['href']
        }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    accounts = doc.css('div.social-icon-container a')
    student = {}
    
    accounts.each do |account|
      social_media = account.attributes["href"].value      
      if social_media.include?("twitter")
        student[:twitter] = social_media
      elsif social_media.include?("linkedin")
        student[:linkedin] = social_media
      elsif social_media.include?("github")
        student[:github] = social_media
      else
        student[:blog] = social_media
      end
    end
    
    student[:profile_quote] = doc.css('div.vitals-text-container div.profile-quote').text
    student[:bio] = doc.css('div.bio-block.details-block div.description-holder p').text
    student
  end
end

