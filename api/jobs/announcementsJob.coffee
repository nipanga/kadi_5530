#
#
#
Cron = require 'cron'
FindXur = require '../find_xur'
Milestones = require '../bungie/milestones'



class AnnouncementsJob

  xur_location_job: ->
    #     ┌────────────── second (optional)
    #     | ┌──────────── minute
    #     | | ┌────────── hour
    #     | | | ┌──────── day of month
    #     | | | | ┌────── month
    #     | | | | | ┌──── day of week
    #     | | | | | |
    #     | | | | | |
    #     * * * * * *
    #
    # Xûr appears at Fridays 6:00 p.m. BST | GMT -0300 2 p.m. (Brazil) (standard time)
    #
    # Weekend Announcements
    Cron.job('0 0 16 * * 5,6,0,1', ->
      FindXur.location()
    ).start


  flashpoint_location_job: ->
    # Flashpoints resets every 4 days.
    Cron.job('30 6 21 * * *', ->
        this.get_week_flashpoint
    ).start



module.exports = AnnouncementsJob