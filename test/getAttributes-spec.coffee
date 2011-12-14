buster.spec.expose()

describe 'Ember.Request#getAttributes', ->    
  it 'should return valid JSON Object', ->
    App = Ember.Application.create()
    App.Model = Ember.Object.extend Ember.Request, 
      modelName: 'widget'
      attributes: ['name', 'description', 'serial', 'model']
    attr = name: 'WidgetA', description: 'Shiny', serial: 'blue', model: 'green'
    model = App.Model.create(attr)
    expect(model.getAttributes()).toEqual attr
  