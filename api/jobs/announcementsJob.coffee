#
Cron = require 'cron'
FindXur = require '../find_xur'
Milestones = require '../bungie/milestones'


test_cron_string = '30 26 01 * * *'

module.exports = {

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
#    Cron.job(test_cron_string, ->
    Cron.job('0 0 16 * * 5,6,0,1', ->
      FindXur.location()
    ).start()


  flashpoint_location_job: ->
    # Flashpoints resets every 4 days, but man, it is hard to get the days correctly in this cron string...
    # So it sends the message at Fridays and Tuesdays.
#    Cron.job(test_cron_string, ->
    Cron.job('0 0 16 * * 5,2', ->
        Milestones.get_week_flashpoint()
    ).start()

}