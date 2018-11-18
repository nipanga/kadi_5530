#
request = require 'request'
bot = require './bot'

API_BRAYTECH_XUR = 'https://api.braytech.org/?request=xur&get=history'

module.exports = {

  location: ->
    self = this
    opts = {
      url: API_BRAYTECH_XUR,
    }
    request.get(opts, (error, response, body) ->
      if (error)
        console.log error
      try
        parsed_body = JSON.parse(body).response.data
        location = "Xûr está em #{parsed_body.location.region} em #{parsed_body.location.world},"
        items = self.items parsed_body.items
        message = "#{location} e está disponível até Terça às 13h00 (horário normal) ou 14h00 (horário de verão)!"
        message += '\nItens nesse fim de semana: \n' + items
        #console.log '###### ###### ######'
        #console.log ': XÛR LOCATION THIS WEEK :'
        #console.log message
        #console.log '###### ###### ######'
        bot.send_message(message)
      catch e
        console.log e
    )

  items: (response_items) ->
    items = []
    response_items.forEach((item) ->
      if item.equippable
        item_description = "- #{item.displayProperties.name} (#{item.itemTypeDisplayName})"
        items.push(item_description)
    )
    items.join("\n")

}