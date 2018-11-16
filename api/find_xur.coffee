#
#
#
rss_parser = require 'rss-parser'
jsdom = require 'jsdom'
date_format = require 'dateformat'
bot = require './bot'

RSS_PARSER = new rss_parser()
{JSDOM} = jsdom

FIND_XUR_RSS = 'https://whereisxur.com/feed/'

class FindXur

  #init: ->
    #Nothing yet

  location: ->
    this.feed = RSS_PARSER.parseURL(FIND_XUR_RSS)
    {document} = (new JSDOM(this.feed.items[0]['content:encoded'])).window
    xur_map_img = document
      .querySelector('div.et_pb_module.et_pb_image.et_pb_image_0.et_always_center_on_mobile')
      .querySelector('span.et_pb_image_wrap').querySelector('img').getAttribute('src')
    pub_date = date_format this.feed.items[0].pubDate
    xur_end_date = new Date pub_date
    xur_end_date.setDate xur_end_date.getDate() + 4
    now = new Date()
    location = document.querySelector('div.et_pb_text_inner').querySelector('h2').textContent
    items = this.items(document).join('\n')
    message = location +' and is available until ' + xur_end_date +'! \nSee the map below to know where he is.'
    message += '\nItems this weekend: \n' + items
    # console.log '###### ###### ######'
    # console.log ': XÛR LOCATION THIS WEEK :'
    # console.log message
    # console.log '###### ###### ######'
    bot.send_message(message)
    bot.send_photo(xur_map_img)


  items: (document) ->
    items = []
    document.querySelectorAll('div.et_pb_blurb_content').forEach((item) ->
      itemName = item.querySelector('div.et_pb_blurb_container').querySelector('h4.et_pb_module_header')
        .textContent.replace(/\s+/g, ' ').trim()
      itemDesc = item.querySelector('div.et_pb_blurb_container').querySelector('div.et_pb_blurb_description')
        .textContent.replace(/\s+/g, ' ').trim()
      items.push '- ' + itemName +' (' + itemDesc +')'
    )
    items

module.exports = FindXur