# # Ember.Request Mixin
#
# Ember.Request is a Mixin to add Resource Methods to your EmberJs Objects.
#
# Usage:
#
# App = Ember.Application.create();
# App.MyObject = Ember.Object.extend(Ember.Request, { 
#   attributes: ['name', 'make', 'engineer']
#   , modelName: 'widget' 
#   , name: 'default'
#   , make: 'light'
#   , engineer: 'Fred'
# });
# 
# 
window.Ember.Request ?= Ember.Request = Ember.Mixin.create
  # # attributes property
  # 
  # The attributes property contains an array of model attributes 
  # that is used to produce a serializable json document that
  # can be sent to a remote server
  attributes: []

  # # modelName property
  #
  # The modelName property is the name of the model we want to 
  # send to the server or retrieve from the server.  We
  # are using the standard rest naming conventions
  #
  # get /[modelName] # returns all
  # post /[modelName] # creates a new model record
  # get /[modelName]/[id] # returns a specific model record
  # put /[moduleName]/[id] # updates a specific model record
  # delete /[modelName]/[id] # deletes a specific model record
  modelName: null

  # # isNewRecord property
  #
  # The isNewRecord property lets ember-request know if this 
  # record exists on the server or not.

  isNewRecord: true

  # # errors property
  # 
  # The errors property contains an array of errors returned from
  # the server.
  errors: []

  # # getAttributes method
  #
  # The getAttribute method returns a Javascript object that is capable of being stringified to JSON
  getAttributes: ->
    data = {}
    for attribute in Ember.get this, 'attributes'
      data[attribute] = Ember.get this, attribute 
    data

  # # printAttr method
  #
  # This method is a helper method that can be used to generate
  # a list of attributes.
  # It is really helpful for models that have a large amount of attributes
  #
  printAttr: ->
    attr = []
    attr.push k for k, v of @
    attr.join(' ')
  
  # # post method
  #
  # The post method wraps the jQuery ajax post method and pulls and JSONifies the models attributes
  # along with getting the csrf-token to submit to a rails application.
  post: (url, cb) ->
    console.log 'Posting...'
    data = { }
    data[@get('modelName')] = @getAttributes()
    data['authenticity_token'] = $('meta[name=csrf-token]').attr('content')
    console.log data
    $.post(url, data, null, "json")
      .success( (data, txtStatus) =>
        cb null, data
      )
      .error( (data, txtStatus) =>
        cb new Error("Server Error: #{txtStatus}"), data
      )
    true
  
  # # put method
  #
  #

  put: (url, cb) ->
    data = { }
    data[@get('modelName')] = @getAttributes()
    data['authenticity_token'] = $('meta[name=csrf-token]').attr('content')
    data['_method'] = "put"
    $.post(url, data, null, "json")
      .success( (data, txtStatus) =>
        console.log 'Success...'
        cb null, data
      )
      .error( (data, txtStatus) =>
       console.log 'Fail...'
       cb new Error("Server Error: #{txtStatus}")
      )
    true
  # 
  # # delete method
  #
  #
  delete: (url, cb) ->
    data = { }
    data[@get('modelName')] = @getAttributes()
    data['authenticity_token'] = $('meta[name=csrf-token]').attr('content')
    data['_method'] = "delete"
    $.post(url, data, null, "json")
      .success( (data, txtStatus) =>
        console.log 'Success...'
        cb null, data
      )
      .error( (data, txtStatus) =>
        console.log 'Fail...'
        cb new Error("Server Error: #{txtStatus}"), data
      )
    true
      
  # 
