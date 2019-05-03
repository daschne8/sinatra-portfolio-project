require 'open-uri'

class Scraper
  STEAM = "https://store.steampowered.com/app/"

  def self.scrape(app_id)
    html = open(STEAM+app_id)
    doc = Nokogiri::HTML(html)

    tags = doc.css("div.popular_tags a").collect do |tag|
      tag.text.strip
    end

    dev = doc.css("div.dev_row .summary a").first.text

    desc = doc.css("div.game_description_snippet").text.strip

    return {developer: dev, genres: tags, description: desc}
  end

end
