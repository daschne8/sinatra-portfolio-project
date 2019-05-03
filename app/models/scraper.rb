require 'open-uri'

class Scraper
  STEAM = "https://store.steampowered.com/app/"

  def self.scrape(app_id)
    html = open(STEAM+app_id)
    doc = Nokogiri::HTML(html)
    if doc
      tags = doc.css("div.popular_tags a").collect do |tag|
        if tag
          tag.text.strip
        else
          "error"
        end
      end

      if doc.css("div.dev_row .summary a").first
        dev = doc.css("div.dev_row .summary a").first.text
      else
        dev = "error"
      end

      if doc.css("div.game_description_snippet").text.strip
        desc = doc.css("div.game_description_snippet").text.strip
      else
        desc = "error"
      end
    end

    return {developer: dev, genres: tags, description: desc}
  end

end
