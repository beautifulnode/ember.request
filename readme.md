# Ember.Request

Ember.Request is a simple mixin for the EmberJs Framework.  The mixin adds resource method
to your Ember Object to connect with an http interface.

## Mixin Properties

* modelName
* attributes

## Mixin Methods

* post
* put
* delete

Each of these methods wrap the jQuery api and provides callbacks to indicate success or error.

``` coffeescript

App = Ember.Application.create()
App.Model = Ember.Object.extend Ember.Request, 
  modelName: "cog"
  attributes: ["name"]

myModel = App.Model.create name: "FOO"

myModel.post '/cogs', (err, cog) -> console.log "Successfully posted #{cog.name}..."

```

It is important to define the modelName and attributes, or the Mixin will not know how
to build a JSON compatible file to upload to a Rails Server.

