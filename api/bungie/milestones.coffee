#
#
#
Config = require '../../config/config.json'
Destiny2Api = require '../../config/destiny2Api.json'
Destiny2Milestones = require '../../config/destiny2Milestones.json'
Bungie = require './bungie'
fs = require 'fs'


class Milestones

  get_milestones:  () ->
    Bungie.call_request_uri Destiny2Api.METHODS.GET_PUBLIC_MILESTONES.VERB, Destiny2Api.METHODS.GET_PUBLIC_MILESTONES.URI

  get_milestone_content: (milestone_hash) ->
    path_params = []
    path_params["MILESTONE_HASH"] = milestone_hash
    Bungie.call_request_uri Destiny2Api.METHODS.GET_PUBLIC_MILESTONE_CONTENT.VERB,
      Destiny2Api.METHODS.GET_PUBLIC_MILESTONE_CONTENT, params

  get_week_flashpoint: () ->
    this.get_milestones().then((result) ->
      flashpoint_hash = Destiny2Milestones.FLASHPOINT.HASH
      inventoryItemDefinition = Destiny2Api.METHODS.GET_DESTINY_ENTITY_DEFINITION.ENTITIES.INVENTORY_ITEM
      flashpoint_quest_hash = result.Response[flashpoint_hash]['availableQuests'][0]['questItemHash']
      Bungie.get_entity_definition(inventoryItemDefinition, flashpoint_quest_hash).then((result) ->
        result
      )
    )


module.exports = Milestones