#
TelegramBot = require 'node-telegram-bot-api'
Env = require '../config/environment'

BOT_OPTIONS = {
  polling: true
}

Bot = new TelegramBot Env.TG_BOT_TOKEN, BOT_OPTIONS

Bot.on 'callback_query', (callbackQuery) ->
  msg = callbackQuery.message
  opts = {
    chat_id: msg.chat.id,
    message_id: msg.message_id
  }
  Bot.editMessageText text, opts

module.exports = {

  send_message: (message) ->
    Bot.sendMessage Env.TG_GROUP_CHAT, message

  send_photo: (img, caption) ->
    Bot.sendPhoto Env.TG_GROUP_CHAT, img, {caption: caption}

}