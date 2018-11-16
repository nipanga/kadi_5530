#
#
#
express = require 'express'
app = express()
https = require 'https'
fs = require 'fs'
announcements_job = require './api/jobs/announcementsJob'
Env = require './config/environment'

Milestones = require './api/bungie/milestones'

#key = fs.readFileSync('~/kadi-5530/certs/private.key')
#cert = fs.readFileSync('certs/primary.crt')
#ca = fs.readFileSync('certs/intermediate.crt')

#var CRT_OPTIONS = {
#    key: key,
#    cert: cert,
#    ca: ca
#}


app.listen Env.SERVER_PORT, () ->
  console.log 'Destiny 2 Telegram Bot Running On Port ' + Env.SERVER_PORT
  announcements_job.xur_location_job
  announcements_job.flashpoint_location_job
