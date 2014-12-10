require('../prepare')()
moment = require 'moment'
Base = require '../../models/base'

describe 'Base', ->
  describe '@dateFields', ->
    class Model extends Base
      @dateFields 'timestamp'

    it 'converts passed string to moment object', ->
      obj = new Model timestamp: '31.01.2014'
      expect(moment.isMoment(obj.timestamp)).toBe(true)

  describe '@hasOne', ->
    class Assoc extends Base

    class Model extends Base
      @hasOne 'assoc', Assoc

    it 'converts passed object', ->
      obj = new Model
      obj.assoc = a: 1
      expect(obj.assoc.constructor).toBe(Assoc)

  describe '@hasMany', ->
    class Assoc extends Base

    class Model extends Base
      @hasMany 'assocs', Assoc

    it 'assocs empty be default', ->
      obj = new Model
      expect(obj.assocs.length).toBe(0)

    it 'converts passed objects to instances of assoc class', ->
      obj = new Model assocs: [{ a: 1 }]
      expect(obj.assocs[0].constructor).toBe(Assoc)

    it 'converts pushed objects', ->
      obj = new Model
      obj.assocs.push a: 1
      expect(obj.assocs[0].constructor).toBe(Assoc)

    it 'converts unshifted objects', ->
      obj = new Model
      obj.assocs.unshift a: 1
      expect(obj.assocs[0].constructor).toBe(Assoc)
