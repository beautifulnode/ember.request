buster.spec.expose()

describe 'Ember.Request#post', ->    
  it 'should post JSON Object', ->
    App = Ember.Application.create()
    App.Model = Ember.Object.extend Ember.Request, 
      modelName: 'widget'
      attributes: ['name', 'description', 'serial', 'model']
    attr = name: 'WidgetA', description: 'Shiny', serial: 'blue', model: 'green'
    model = App.Model.create(attr)
    @stub $, 'post', -> $ 
    @stub $, 'success', -> $
    @stub $. 'error', -> $
    #model.post (err, result) ->
      #
