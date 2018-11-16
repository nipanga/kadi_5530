#
#
#
TelegramBot = require 'node-telegram-bot-api'
Config = require '../config/config'

BOT_OPTIONS = {
  polling: true
}

Bot = new TelegramBot Config.BOT_TOKEN, BOT_OPTIONS

Bot.on 'callback_query', (callbackQuery) ->
  msg = callbackQuery.message
  opts = {
    chat_id: msg.chat.id,
    message_id: msg.message_id
  }
  Bot.editMessageText text, opts

class Bot

  send_message: (message) ->
    Bot.sendMessage Config.GROUP_CHAT.TM_DESTINY_2, message

  send_photo: (img, caption) ->
    Bot.sendPhoto Config.GROUP_CHAT.TM_DESTINY_2, img, {caption: caption}

module.exports = Bot