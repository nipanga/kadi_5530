#
request = require 'request'
Destiny2Api = require '../../config/destiny2Api.json'
Env = require '../../config/environment'

PARAM_MEMBERSHIP_TYPE = Destiny2Api.METHODS.SEARCH_DESTINY_PLAYER.PATH_PARAMETERS.MEMBERSHIP_TYPE
PARAM_PLAYER_ID = Destiny2Api.METHODS.SEARCH_DESTINY_PLAYER.PATH_PARAMETERS.DISPLAY_NAME

PARAM_ENTITY_TYPE = Destiny2Api.METHODS.GET_DESTINY_ENTITY_DEFINITION.PATH_PARAMETERS.ENTITY_TYPE
PARAM_HASH_IDENTIFIER = Destiny2Api.METHODS.GET_DESTINY_ENTITY_DEFINITION.PATH_PARAMETERS.HASH_IDENTIFIER

PARAM_MEMBERSHIP_ID = Destiny2Api.METHODS.GET_PROFILE.PATH_PARAMETERS.DESTINY_MEMBERSHIP_ID


module.exports = {

  call_request_uri: (verb, uri, params, options) ->
    if (params)
      for key, value of params
        uri = uri.replace(new RegExp(key, "g"), encodeURIComponent(value));
    full_uri = Destiny2Api.ROOT_URL + Destiny2Api.DESTINY_2_BASE + uri;
    opts = {
      url: full_uri,
      headers: {
        "X-API-Key": Env.HEADERS.X_API_KEY
      }
    }
    new Promise((resolve, reject) ->
      request.get(opts, (error, response, body) ->
        if (error)
          reject error
        try
          resolve(JSON.parse(body));
        catch e
          reject e
      )
    )

  get_destiny_manifest: ->
    this.call_request_uri Destiny2Api.METHODS.GET_DESTINY_MANIFEST.VERB,
      Destiny2Api.METHODS.GET_DESTINY_MANIFEST.URI

  search_destiny_player: (player_id) ->
    params = []
    params[PARAM_MEMBERSHIP_TYPE] = Destiny2Api.MEMBERSHIP_TYPES.BUNGIE_NET
    params[PARAM_PLAYER_ID] = player_id
    this.call_request_uri Destiny2Api.METHODS.SEARCH_DESTINY_PLAYER.VERB,
        Destiny2Api.METHODS.SEARCH_DESTINY_PLAYER.URI, params

  get_profile: (membership_id) ->
    options = {
      headers: DEFAULT_HEADER,
      qs: [
        {'components': Destiny2Api.QUERY_PARAMETERS.COMPONENTS.PROFILES}
      ]
    }
    path_params = []
    path_params[PARAM_MEMBERSHIP_TYPE] = Destiny2Api.MEMBERSHIP_TYPES.BUNGIE_NET
    path_params[PARAM_MEMBERSHIP_ID] = membership_id
    this.call_request_uri Destiny2Api.METHODS.GET_PROFILE.VERB, Destiny2Api.METHODS.GET_PROFILE.URI, path_params,
        options

  get_entity_definition: (entity_type, entity_hash) ->
    path_parameters = [];
    path_parameters[PARAM_ENTITY_TYPE] = entity_type
    path_parameters[PARAM_HASH_IDENTIFIER] = entity_hash
    this.call_request_uri Destiny2Api.METHODS.GET_DESTINY_ENTITY_DEFINITION.VERB,
        Destiny2Api.METHODS.GET_DESTINY_ENTITY_DEFINITION.URI, path_parameters

}