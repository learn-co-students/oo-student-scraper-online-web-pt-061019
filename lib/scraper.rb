require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_hash = []
    html =Nokogir::HTML(open(index_url))
    html.css(".student-card").collect do |student|
        hash = { name: studnet.css("h4.student-name").text, 
        location: student.css("p.student-location").text,
        profile_url: {("http://students.learn.co/") + student.csss("a").attritube("href)"}
        
        student_hash << hash
  end
  student_hash
end 


    def self.scrape_profile_page(profile_url)
    student_hash = {}
    
    html = Nokogiri::HTML(open(profile_url))
    html.css("div.social-icon-controller a").each do |student|
      
        url = student.attribute("href")
        student_has[:twitter_url] = url if url.include?("twitter")
        
       students_hash[:linkedin_url] = url if url.include?("linkedin")
       students_hash[:github_url] = url if url.include?("github")
       students_hash[:blog_url] = url if student.css("img").attribute("src").text.include?("rss")
    end
    
    students_hash[:profile_quote] = html.css("div.profile-quote").text
        students_hash[:bio] = html.css("div.bio-content p").text
    students_hash
    
    
    end

end

