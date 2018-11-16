#
#
#

class Env
  @SERVER_URL: process.env.KADI_SERVER_URL
  @SERVER_PORT: process.env.KADI_SERVER_PORT

  @TG_BOT_TOKEN: process.env.KADI_TELEGRAM_BOT_TOKEN
  @TG_GROUP_CHAT: process.env.KADI_GROUP_CHAT

  @HEADERS: {
    X_API_KEY: process.env.KADI_TG_HEADER_X_API_KEY
    CLIENT_ID: process.env.KADI_TG_HEADER_CLIENT_ID
  }

module.exports = Env