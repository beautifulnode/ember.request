(function() {
  var _base, _ref;

  if ((_ref = (_base = window.Ember).Request) == null) {
    _base.Request = Ember.Request = Ember.Mixin.create({
      attributes: [],
      modelName: null,
      isNewRecord: true,
      errors: [],
      getAttributes: function() {
        var attribute, data, _i, _len, _ref2;
        data = {};
        _ref2 = Ember.get(this, 'attributes');
        for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
          attribute = _ref2[_i];
          data[attribute] = Ember.get(this, attribute);
        }
        return data;
      },
      printAttr: function() {
        var attr, k, v;
        attr = [];
        for (k in this) {
          v = this[k];
          attr.push(k);
        }
        return attr.join(' ');
      },
      post: function(url, cb) {
        var data;
        var _this = this;
        console.log('Posting...');
        data = {};
        data[this.get('modelName')] = this.getAttributes();
        data['authenticity_token'] = $('meta[name=csrf-token]').attr('content');
        console.log(data);
        $.post(url, data, null, "json").success(function(data, txtStatus) {
          return cb(null, data);
        }).error(function(data, txtStatus) {
          return cb(new Error("Server Error: " + txtStatus), data);
        });
        return true;
      },
      put: function(url, cb) {
        var data;
        var _this = this;
        data = {};
        data[this.get('modelName')] = this.getAttributes();
        data['authenticity_token'] = $('meta[name=csrf-token]').attr('content');
        data['_method'] = "put";
        $.post(url, data, null, "json").success(function(data, txtStatus) {
          console.log('Success...');
          return cb(null, data);
        }).error(function(data, txtStatus) {
          console.log('Fail...');
          return cb(new Error("Server Error: " + txtStatus));
        });
        return true;
      },
      "delete": function(url, cb) {
        var data;
        var _this = this;
        data = {};
        data[this.get('modelName')] = this.getAttributes();
        data['authenticity_token'] = $('meta[name=csrf-token]').attr('content');
        data['_method'] = "delete";
        $.post(url, data, null, "json").success(function(data, txtStatus) {
          console.log('Success...');
          return cb(null, data);
        }).error(function(data, txtStatus) {
          console.log('Fail...');
          return cb(new Error("Server Error: " + txtStatus), data);
        });
        return true;
      }
    });
  }

}).call(this);
