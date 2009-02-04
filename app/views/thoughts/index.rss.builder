xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("thought")
    xml.link(@basesite)
    xml.description("microblog your thoughts quickly and easily")
    xml.language("en-gb")
    for thought in @thoughts
      xml.item do
        xml.title(thought.content)
        xml.description(thought.content)
        # rfc822
        xml.pubDate(thought.created_at.rfc2822)
      xml.link("#{@basesite}/show/#{thought.id}")
      xml.guid("#{@basesite}/show/#{thought.id}")
      end
    end
  }
}
