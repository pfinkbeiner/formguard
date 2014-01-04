###
# FormGuard - A powerful, customizable, quick and easy jQuery plugin to validate your forms.
#
# @version v1.0
# @author Patrick Finkbeiner @p_finkbeiner <finkbeiner.patrick@gmail.com>
###
class FormGuard
  
  # Selector's
  sel:
    base: undefined

  defaults:
    errorCls: 'invalid'
    live: on
    onFormError: undefined

  settings: {}

  # Contructor
  constructor: (options, selector) ->
    me = @
    @sel.base = selector
    @settings = jQuery.extend true, @defaults, options
    if (jQuery @sel.base).length > 0
      @run()

  
  # Runs form validator for given forms.
  run: ->
    me = @
    if @settings.live is on
      me.onBlur()

    (jQuery @sel.base).each ->
      (jQuery @).submit ->
        me.validate @
        if ((jQuery @).find '.invalid').length > 0
          status = false
          if me.settings.onFormError isnt undefined
            me.settings.onFormError()
        else
          status = true
        status
 
  # Check field on blur
  #
  # @return [Boolean]
  onBlur: ->
    me = @
    (jQuery @sel.base).each ->
      (jQuery 'input, textarea').on 'blur', ->
        valid = me.parse @
        undefined

  # Validates one form after another one (if there a multiple ones)
  #
  # @param [Object] form
  # @return [Boolean]
  validate: (form) ->
    me = @
    ((jQuery form).find 'input, textarea').each ->
      (jQuery @).each ->
        valid = me.parse @
        undefined

  # Check given field 
  #
  # @param [Object] field
  # @return [Boolean]
  parse: (field) ->
    me = @
    options = (jQuery field).attr 'data-validate'
    if options is '' or options is undefined or options is null or options is false
      true # there is no validation necessary.
    else
      options = options.split ' '
      me.check field, options


  # Check field against every validation
  #
  # @param [Object] field
  # @param [Array] options
  check: (field, options) ->
    me = @
    fieldStats = 0
    for i in [0...options.length]
      status = me.validateField (jQuery field).val(), options[i], field
      if status is false
        fieldStats++
    if fieldStats > 0
      (jQuery field).addClass me.settings.errorCls
      false
    else
      (jQuery field).removeClass me.settings.errorCls
      true
    
  # Actual validation
  #
  # @param [String] value
  # @param [String] validator
  # @return [Boolean]
  validateField: (value, validator, field) ->
    me = @
    if ((jQuery field).attr 'type') is 'checkbox' and validator is 'required'
      validator = 'required-checkbox'

    if /min\[/.test validator
      length = validator.replace( /(^.*\[|\].*$)/g, '' )
      validator = 'minimum'

    if /max\[/.test validator
      length = validator.replace( /(^.*\[|\].*$)/g, '' )
      validator = 'maximum'

    if /match\[/.test validator
      name = validator.replace( /(^.*\[|\].*$)/g, '' )
      matchValue = me.getValueForMatch name
      validator = 'matches'

    switch validator
      when "required" then status = me.notEmpty value
      when "required-checkbox" then status = me.requiredCheckbox field
      when "email" then status = me.validEmail value
      when "integer" then status = me.isInteger value
      when "number" then status = me.isNumber value
      when "minimum" then status = me.validMin value, length
      when "maximum" then status = me.validMax value, length
      when "matches" then status = me.matches value, matchValue
    status

  # Validate a required checkbox
  #
  # @param [Html] field
  # @return [Boolean]
  requiredCheckbox: (field) ->
    status = false
    if ((jQuery field).is ':checked') is true
       status = true
    status

  # Gets the value to be matched against.
  #
  # @param [String] name
  # @return [String]
  getValueForMatch: (name) ->
    (jQuery "[name='"+name+"']").val()
      
  # Valiadates against empty string
  #
  # @param [String] value
  # @return [Boolean]
  notEmpty: (value) ->
    /\S/.test value

  # Valiadates against valid email address
  #
  # @param [String] value
  # @return [Boolean]
  validEmail: (value) ->
    regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\ ".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA -Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    regex.test value

  # Validates againsts min length
  #
  # @param [String] value
  # @param [Integer] length
  # @return [Boolean]
  validMin: (value, length) ->
    status = true
    if value.length < length
      status = false
    status


  # validates againsts max length
  #
  # @param [string] value
  # @param [integer] length
  # @return [boolean]
  validMax: (value, length) ->
    status = true
    if value.length > length
      status = false
    status

  # validates againsts valid number
  #
  # @param [string] value
  # @return [boolean]
  isNumber: (value) ->
    !isNaN(parseFloat(value)) && isFinite(value)

  # Matches two fields.
  #
  # @param [String] a
  # @param [String] b
  # @param [Boolean]
  matches: (a, b) ->
    status = false
    if a is b
      status = true
    status

jQuery.fn.formguard = (options) ->
  new FormGuard(options, @.selector)
