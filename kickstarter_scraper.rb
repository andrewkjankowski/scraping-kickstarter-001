# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  projects = {:projects => {}}
  html = File.read('fixtures/kickstarter.html')
 
  kickstarter = Nokogiri::HTML(html)
  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  projects_scrape = kickstarter.css('li.project.grid_4')
  projects_scrape.each do |project|
    project_hash = {}
    project_hash[:image_link] = project.css("div.project-thumbnail a img").attribute("src").value
    project_hash[:description] = project.css("p.bbcard_blurb").text
    project_hash[:location] = project.css('ul.project-meta li a span.location-name').text
    project_hash[:percent_funded] = project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    projects[:projects][project.css('h2.bbcard_name strong a').text] = project_hash
  end
  
  projects[:projects]
end