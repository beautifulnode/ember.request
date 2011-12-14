
  buster.spec.expose();

  describe('Ember.Request#getAttributes', function() {
    return it('should return valid JSON Object', function() {
      var App, attr, model;
      App = Ember.Application.create();
      App.Model = Ember.Object.extend(Ember.Request, {
        modelName: 'widget',
        attributes: ['name', 'description', 'serial', 'model']
      });
      attr = {
        name: 'WidgetA',
        description: 'Shiny',
        serial: 'blue',
        model: 'green'
      };
      model = App.Model.create(attr);
      return expect(model.getAttributes()).toEqual(attr);
    });
  });
