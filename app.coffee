#
require 'coffee-script/register'
express = require 'express'
app = express()

Env = require './config/environment'
AnnouncementsJob = require './api/jobs/announcementsJob'


app.listen Env.SERVER_PORT, () ->
  console.log 'Destiny 2 Telegram Bot Running On Port ' + Env.SERVER_PORT
  AnnouncementsJob.xur_location_job()
  AnnouncementsJob.flashpoint_location_job()
