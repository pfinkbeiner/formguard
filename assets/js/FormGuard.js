// Generated by CoffeeScript 1.6.3
/*
# FormGuard - a rich javascript form validator.
#
# @version v0.1-beta
# @author Patrick Finkbeiner @p_finkbeiner <finkbeiner.patrick@gmail.com>
*/


(function() {
  var FormGuard;

  FormGuard = (function() {
    FormGuard.prototype.sel = {
      base: void 0
    };

    FormGuard.prototype.defaults = {
      errorCls: 'invalid',
      live: true,
      onFormError: void 0
    };

    FormGuard.prototype.settings = {};

    function FormGuard(options, selector) {
      var me;
      me = this;
      this.sel.base = selector;
      this.settings = jQuery.extend(true, this.defaults, options);
      if ((jQuery(this.sel.base)).length > 0) {
        this.run();
      }
    }

    FormGuard.prototype.run = function() {
      var me;
      me = this;
      if (this.settings.live === true) {
        me.onBlur();
      }
      return (jQuery(this.sel.base)).each(function() {
        return (jQuery(this)).submit(function() {
          var status;
          me.validate(this);
          if (((jQuery(this)).find('.invalid')).length > 0) {
            status = false;
            if (me.settings.onFormError !== void 0) {
              me.settings.onFormError();
            }
          } else {
            status = true;
          }
          return status;
        });
      });
    };

    FormGuard.prototype.onBlur = function() {
      var me;
      me = this;
      return (jQuery(this.sel.base)).each(function() {
        return (jQuery('input, textarea')).on('blur', function() {
          var valid;
          valid = me.parse(this);
          return void 0;
        });
      });
    };

    FormGuard.prototype.validate = function(form) {
      var me;
      me = this;
      return ((jQuery(form)).find('input, textarea')).each(function() {
        return (jQuery(this)).each(function() {
          var valid;
          valid = me.parse(this);
          return void 0;
        });
      });
    };

    FormGuard.prototype.parse = function(field) {
      var me, options;
      me = this;
      options = (jQuery(field)).attr('data-validate');
      if (options === '' || options === void 0 || options === null || options === false) {
        return true;
      } else {
        options = options.split(' ');
        return me.check(field, options);
      }
    };

    FormGuard.prototype.check = function(field, options) {
      var fieldStats, i, me, status, _i, _ref;
      me = this;
      fieldStats = 0;
      for (i = _i = 0, _ref = options.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        status = me.validateField((jQuery(field)).val(), options[i]);
        if (status === false) {
          fieldStats++;
        }
      }
      if (fieldStats > 0) {
        (jQuery(field)).addClass(me.settings.errorCls);
        return false;
      } else {
        (jQuery(field)).removeClass(me.settings.errorCls);
        return true;
      }
    };

    FormGuard.prototype.validateField = function(value, validator) {
      var length, matchValue, me, name, status;
      me = this;
      if (/min\[/.test(validator)) {
        length = validator.replace(/(^.*\[|\].*$)/g, '');
        validator = 'minimum';
      }
      if (/max\[/.test(validator)) {
        length = validator.replace(/(^.*\[|\].*$)/g, '');
        validator = 'maximum';
      }
      if (/match\[/.test(validator)) {
        name = validator.replace(/(^.*\[|\].*$)/g, '');
        matchValue = me.getValueForMatch(name);
        validator = 'matches';
      }
      switch (validator) {
        case "required":
          status = me.notEmpty(value);
          break;
        case "email":
          status = me.validEmail(value);
          break;
        case "integer":
          status = me.isInteger(value);
          break;
        case "number":
          status = me.isNumber(value);
          break;
        case "minimum":
          status = me.validMin(value, length);
          break;
        case "maximum":
          status = me.validMax(value, length);
          break;
        case "matches":
          status = me.matches(value, matchValue);
      }
      return status;
    };

    FormGuard.prototype.getValueForMatch = function(name) {
      return (jQuery("[name='" + name + "']")).val();
    };

    FormGuard.prototype.notEmpty = function(value) {
      return /\S/.test(value);
    };

    FormGuard.prototype.validEmail = function(value) {
      var regex;
      regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\ ".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA -Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return regex.test(value);
    };

    FormGuard.prototype.validMin = function(value, length) {
      var status;
      status = true;
      if (value.length < length) {
        status = false;
      }
      return status;
    };

    FormGuard.prototype.validMax = function(value, length) {
      var status;
      status = true;
      if (value.length > length) {
        status = false;
      }
      return status;
    };

    FormGuard.prototype.isNumber = function(value) {
      return !isNaN(parseFloat(value)) && isFinite(value);
    };

    FormGuard.prototype.matches = function(a, b) {
      var status;
      status = false;
      if (a === b) {
        status = true;
      }
      return status;
    };

    return FormGuard;

  })();

  jQuery.fn.formguard = function(options) {
    return new FormGuard(options, this.selector);
  };

}).call(this);
