'use strict';
var sixmodel = require('./sixmodel.js');
var Hash = require('./hash.js');
var NQPInt = require('./nqp-int.js');
var NQPException = require('./nqp-exception.js');
var Null = require('./null.js');
var null_s = require('./null_s.js');
var Iter = require('./iter.js');
var BOOT = require('./BOOT.js');

var bignum = require('bignum');
var ZERO = bignum(0);

var constants = require('./constants.js');

const EDGE_FATE = 0, EDGE_EPSILON = 1, EDGE_CODEPOINT = 2, EDGE_CODEPOINT_NEG = 3, EDGE_CHARCLASS = 4, EDGE_CHARCLASS_NEG = 5;
const EDGE_CHARLIST = 6, EDGE_CHARLIST_NEG = 7, EDGE_SUBRULE = 8, EDGE_CODEPOINT_I = 9, EDGE_CODEPOINT_I_NEG = 10;
const EDGE_GENERIC_VAR = 11, EDGE_CHARRANGE = 12, EDGE_CHARRANGE_NEG = 13, EDGE_CODEPOINT_LL = 14, EDGE_CODEPOINT_I_LL = 15;

var reprs = {};
var reprById = [];

function basicTypeObjectFor(HOW) {
  var st = new sixmodel.STable(this, HOW);
  this._STable = st;

  var obj = st.createTypeObject();
  this._STable.WHAT = obj;

  return obj;
}

function basicAllocate(STable) {
  return new STable.objConstructor();
}

function noopCompose(obj, reprInfo) {
}


function basicConstructor(STable) {
  var objConstructor = function() {};
  var handler = {};
  handler.get = function(target, name) {
    if (STable.modeFlags & constants.METHOD_CACHE_AUTHORITATIVE) {
      return undefined;
    }

    /* are we trying to access an internal property? */
    if (name.substr(0, 2) === '$$') {
      return undefined;
    }

    return function() {
      let how = this._STable.HOW;

      var method = how.find_method(null, null, how, this, name);

      var args = [];
      for (var i = 0; i < arguments.length; i++) {
        args.push(arguments[i]);
      }
      return method.$$apply(args);
    };
  };


  objConstructor.prototype = Object.create(new Proxy({}, handler));
  objConstructor.prototype._STable = STable;

  objConstructor.prototype._SC = undefined;
  objConstructor.prototype._WHERE = undefined;

  return objConstructor;
}

function slotToAttr(slot) {
  return 'attr$' + slot;
}

class REPR {
};
REPR.prototype.allocate = basicAllocate;
REPR.prototype.typeObjectFor = basicTypeObjectFor;
REPR.prototype.compose = noopCompose;
REPR.prototype.createObjConstructor = basicConstructor;

class P6opaque {
  allocate(STable) {
    var obj = new STable.objConstructor();
    obj.$$setDefaults();
    return obj;
  }

  deserializeReprData(cursor, STable) {
    this.deserialized = 1;
    var numAttributes = cursor.varint();
    this.flattenedSTables = [];
    for (var i = 0; i < numAttributes; i++) {
      var notNull = cursor.varint();
      this.flattenedSTables.push(notNull != 0 ? cursor.locateThing('rootSTables') : null);
    }
    this.mi = cursor.varint();
    var hasAutoVivValues = cursor.varint();
    if (hasAutoVivValues != 0) {
      this.autoVivValues = [];
      for (var i = 0; i < numAttributes; i++) {
        this.autoVivValues.push(cursor.variant());
      }
    }

    this.unboxIntSlot = cursor.varint();
    this.unboxNumSlot = cursor.varint();
    this.unboxStrSlot = cursor.varint();



    var hasUnboxSlots = cursor.varint();

    if (hasUnboxSlots != 0) {
      this.unboxSlots = [];
      for (var i = 0; i < numAttributes; i++) {
        var reprId = cursor.varint();
        var slot = cursor.varint();
        if (reprId != 0) {
          this.unboxSlots.push({slot: slot, reprId: reprId});
        }
      }
    }

    var numClasses = cursor.varint();
    this.nameToIndexMapping = [];

    var slots = [];

    for (var i = 0; i < numClasses; i++) {
      this.nameToIndexMapping[i] = {slots: [], names: [], classKey: cursor.variant()};

      var numAttrs = cursor.varint();

      for (var j = 0; j < numAttrs; j++) {
        var name = cursor.str();
        var slot = cursor.varint();

        this.nameToIndexMapping[i].names[j] = name;
        this.nameToIndexMapping[i].slots[j] = slot;


        slots[slot] = name;
      }
    }


    this.positionalDelegateSlot = cursor.varint();
    this.associativeDelegateSlot = cursor.varint();

    if (this.positionalDelegateSlot != -1) {
      STable.setPositionalDelegate(slotToAttr(this.positionalDelegateSlot));
    }
    if (this.associativeDelegateSlot != -1) {
      STable.setAssociativeDelegate(slotToAttr(this.associativeDelegateSlot));
    }

    if (this.unboxSlots) {
      for (var i = 0; i < this.unboxSlots.length; i++) {
        var slot = this.unboxSlots[i].slot;
        (new reprById[this.unboxSlots[i].reprId]).generateBoxingMethods(STable, slotToAttr(slot), this.flattenedSTables[slot]);
      }
    }

    this.generateAccessors(STable);
  }

  hintfor(classHandle, attrName) {
    if (!this.nameToIndexMapping) {
      return -1;
    }
    for (var i = 0; i < this.nameToIndexMapping.length; i++) {
      if (this.nameToIndexMapping[i].classKey === classHandle) {
        for (var j = 0; j < this.nameToIndexMapping[i].slots.length; j++) {
          if (this.nameToIndexMapping[i].names[j] === attrName) {
            return this.nameToIndexMapping[i].slots[j];
          }
        }
      }
    }
    return -1;
  }

  getHint(classHandle, attrName) {
    var hint = this.hintfor(classHandle, attrName);
    if (hint == -1) {
      throw new NQPException("Can't find: " + attrName);
    } else {
      return hint;
    }
  }

  getterForAttr(classHandle, attrName) {
    return '$$getattr$' + this.getHint(classHandle, attrName);
  }

  serializeReprData(st, cursor) {
    var numAttrs = st.REPR.flattenedSTables.length;
    cursor.varint(numAttrs);

    for (var i = 0; i < numAttrs; i++) {
      if (st.REPR.flattenedSTables[i] == null) {
        cursor.varint(0);
      }
      else {
        cursor.varint(1);
        cursor.STableRef(st.REPR.flattenedSTables[i]);
      }
    }

    cursor.varint(st.REPR.mi ? 1 : 0);


    if (st.REPR.autoVivValues) {
      cursor.varint(1);
      for (var i = 0; i < numAttrs; i++) {
        cursor.ref(st.REPR.autoVivValues[i]);
      }
    } else {
      cursor.varint(0);
    }


    cursor.varint(st.REPR.unboxIntSlot);
    cursor.varint(st.REPR.unboxNumSlot);
    cursor.varint(st.REPR.unboxStrSlot);

    if (this.unboxSlots) {
      cursor.varint(1);
      for (var i = 0; i < numAttrs; i++) {
        if (this.unboxSlots[i]) {
          cursor.varint(this.unboxSlots[i].reprId);
          cursor.varint(this.unboxSlots[i].slot);
        } else {
          cursor.varint(0);
          cursor.varint(0);
        }
      }
    } else {
      cursor.varint(0);
    }


    cursor.varint(this.nameToIndexMapping.length);
    for (var i = 0; i < this.nameToIndexMapping.length; i++) {
      cursor.ref(this.nameToIndexMapping[i].classKey);

      var numAttrs = this.nameToIndexMapping[i].names.length;

      cursor.varint(numAttrs);

      for (var j = 0; j < numAttrs; j++) {
        cursor.str(this.nameToIndexMapping[i].names[j]);
        cursor.varint(this.nameToIndexMapping[i].slots[j]);
      }
    }

    cursor.varint(this.positionalDelegateSlot);
    cursor.varint(this.associativeDelegateSlot);
  }

  deserializeFinish(obj, data) {
    var attrs = [];

    for (var i = 0; i < this.flattenedSTables.length; i++) {
      if (this.flattenedSTables[i]) {
        attrs.push(this.flattenedSTables[i].REPR.deserializeInline(data));
      } else {
        attrs.push(data.variantWithUndefined());
      }
    }

    for (var mapping of this.nameToIndexMapping) {
      for (var slot of mapping.slots) {
        obj[slotToAttr(slot)] = attrs[slot];
      }
    }
  }

  serialize(cursor, obj) {
    var flattened = obj._STable.REPR.flattenedSTables;
    var nqp = require('nqp-runtime');
    if (!flattened) {
      throw 'Representation must be composed before it can be serialized';
    }

    for (var i = 0; i < flattened.length; i++) {
      var value = obj[slotToAttr(i)];

      if (flattened[i] == null) {
        cursor.ref(value);
      } else {
        flattened[i].REPR.serializeInline(cursor, value);
      }
    }
  }

  changeType(obj, newType) {
    // TODO some sanity checks for the new mro being a subset and newType being also a P6opaque

    let newREPR = newType._STable.REPR;

    for (var i = 0; i < newREPR.nameToIndexMapping.length; i++) {
      for (var j = 0; j < newREPR.nameToIndexMapping[i].slots.length; j++) {
        let slot = newREPR.nameToIndexMapping[i].slots[j];
        let defaultValue = newREPR.flattenedSTables[slot] ?
            newREPR.flattenedSTables[slot].REPR.flattenedDefaultObj :
            undefined;
        let attr = slotToAttr(slot);
        if (!Object.prototype.hasOwnProperty.call(obj, attr)) {
          obj[attr] = defaultValue;
        }
      }
    }

    Object.setPrototypeOf(obj, newType._STable.objConstructor.prototype);
  }

  compose(STable, reprInfoHash) {
    // TODO

    /* Get attribute part of the protocol from the hash. */
    var reprInfo = reprInfoHash.content.get('attribute').array;

    /* Go through MRO and find all classes with attributes and build up
     * mapping info hashes. Note, reverse order so indexes will match
     * those in parent types. */

    this.unboxIntSlot = -1;
    this.unboxNumSlot = -1;
    this.unboxStrSlot = -1;

    this.positionalDelegateSlot = -1;
    this.associativeDelegateSlot = -1;

    var curAttr = 0;
    this.nameToIndexMapping = [];
    this.flattenedSTables = [];
    var mi = false;

    this.autoVivValues = [];

    for (var i = reprInfo.length - 1; i >= 0; i--) {
      var entry = reprInfo[i].array;
      var type = entry[0];
      var attrs = entry[1].array;
      var parents = entry[2].array;

      /* If it has any attributes, give them each indexes and put them
         * in the list to add to the layout. */
      var numAttrs = attrs.length;
      if (numAttrs > 0) {
        var names = [];
        var slots = [];

        for (var j = 0; j < numAttrs; j++) {
          var attr = attrs[j].content;

          var attrType = attr.get('type');
          /* old boxing method generation */
          if (attr.get('box_target')) {
            var REPR = attrType._STable.REPR;
            if (!this.unboxSlots) this.unboxSlots = [];
            this.unboxSlots.push({slot: curAttr, reprId: REPR.ID});
            REPR.generateBoxingMethods(STable, slotToAttr(curAttr), attrType._STable);
          }

          slots.push(curAttr);
          names.push(attr.get('name'));

          if (attrType !== undefined && attrType !== Null && attrType._STable.REPR.flattenSTable) {
            this.flattenedSTables.push(attrType._STable);
          } else {
            this.flattenedSTables.push(null);
          }

          if (attr.get('positional_delegate')) {
            this.positionalDelegateSlot = curAttr;
            this._STable.setPositionalDelegate(slotToAttr(this.positionalDelegateSlot));
          }

          if (attr.get('associative_delegate')) {
            this.associativeDelegateSlot = curAttr;
            this._STable.setAssociativeDelegate(slotToAttr(this.associativeDelegateSlot));
          }

          if (attr.get('auto_viv_container')) {
            this.autoVivValues[curAttr] = attr.get('auto_viv_container');
          } else {
            this.autoVivValues[curAttr] = Null;
          }

          curAttr++;
        }
        this.nameToIndexMapping.push({classKey: type, slots: slots, names: names});
      }

      /* Multiple parents means it's multiple inheritance. */
      if (parents.length > 1) {
        mi = true;
      }
    }

    /* Populate some REPR data. */
    this.mi = mi ? 1 : 0;

    this.generateAccessors(STable);
  }

  generateNormalAccessors(STable, slot) {
    var attr = slotToAttr(slot);

    STable.compileAccessor('$$bindattr$' + slot, 'function(value) {\n' +
        'this.' + attr + ' = value;\n' +
        'if (this._SC !== undefined) this.$$scwb();\n' +
        'return value;\n' +
        '}\n');

    if (this.autoVivValues && this.autoVivValues[slot] !== Null) {
      var isTypeObject = this.autoVivValues[slot].typeObject_;

      STable.compileAccessor('$$getattr$' + slot, 'function(value) {\n' +
          'var value = this.' + attr + ';\n' +
          'if (value === undefined) {\n' +
          'value = autoViv' + slot + (isTypeObject ? '' : '.$$clone()') + ';\n' +
          'this.' + attr + ' =  value;\n' +
          '}\n' +
          'return value;\n' +
          '}\n', 'var autoViv' + slot + ' = STable.REPR.autoVivValues[' + slot + '];\n');
    } else {
      STable.compileAccessor('$$getattr$' + slot, 'function(value) {\n' +
          'var value = this.' + attr + ';\n' +
          'if (value === undefined) {\n' +
          'return Null;\n' +
          '}\n' +
          'return value;' +
          '}\n'
      );
    }

  }

  generateDefaults(STable) {
    var code = '';

    for (var i = 0; i < this.nameToIndexMapping.length; i++) {
      for (var j = 0; j < this.nameToIndexMapping[i].slots.length; j++) {
        let slot = this.nameToIndexMapping[i].slots[j];
        let defaultValue = this.flattenedSTables[slot] ?
            this.flattenedSTables[slot].REPR.flattenedDefault :
            'undefined';
        code += 'this.' + slotToAttr(slot) + ' = ' + defaultValue + ';\n';
      }
    }

    STable.compileAccessor('$$setDefaults', 'function() {\n' + code + '}');
    STable.evalGatheredCode();
  }

  generateUniversalAccessors(STable) {
    this.generateUniversalAccessor(STable, '$$getattr', function(slot) {
      return 'return this.$$getattr$' + slot + '()';
    }, '', false);

    this.generateUniversalAccessor(STable, '$$bindattr', function(slot) {
      return 'return this.$$bindattr$' + slot + '(value)';
    }, ', value', false);

    var suffixes = ['_s', '_i', '_n'];
    for (let suffix of suffixes) {
      /* TODO only check attributes of proper type */
      this.generateUniversalAccessor(STable, '$$getattr' + suffix, function(slot) {
        return 'return this.' + slotToAttr(slot);
      }, '', false);

      this.generateUniversalAccessor(STable, '$$bindattr' + suffix, function(slot) {
        return 'return (this.' + slotToAttr(slot) + ' = value)';
      }, ', value', true);
    }
  }

  generateUniversalAccessor(STable, name, action, extraSig, scwb) {
    var code = 'function(classHandle, attrName' + extraSig + ') {\n' +
      (scwb ? 'if (this._SC !== undefined) this.$$scwb();\n' : '') +
      'switch (classHandle) {\n';
    var classKeyIndex = 0;
    var setup = '';
    if (this.nameToIndexMapping) {
      for (var i = 0; i < this.nameToIndexMapping.length; i++) {
        let classKey = 'classKey' + classKeyIndex;
        setup += 'var ' + classKey + ' = STable.REPR.nameToIndexMapping[' + i + '].classKey;\n';
        code += 'case ' + classKey + ': switch (attrName) {\n';
        for (var j = 0; j < this.nameToIndexMapping[i].slots.length; j++) {
          let slot = this.nameToIndexMapping[i].slots[j];
          code += 'case \'' + this.nameToIndexMapping[i].names[j] + '\':' + action(slot) + ';\n';
        }
        code += '}\n';
        classKeyIndex++;
      }
    }
    code += '}\n}\n';
    STable.compileAccessor(name, code, setup);
  }

  generateAccessors(STable) {
    for (var i = 0; i < this.nameToIndexMapping.length; i++) {
      for (var j = 0; j < this.nameToIndexMapping[i].slots.length; j++) {
        let slot = this.nameToIndexMapping[i].slots[j];
        if (this.flattenedSTables[slot]) {
          this.flattenedSTables[slot].REPR.generateFlattenedAccessors(STable, this.flattenedSTables[slot], slot);
        } else {
          this.generateNormalAccessors(STable, slot);
        }
      }
    }

    this.generateUniversalAccessors(STable);

    this.generateDefaults(STable);

    STable.evalGatheredCode();
  }

  setupSTable(STable) {
    var repr = this;
    STable.addInternalMethods(class {
      $$attrinited(classHandle, attrName) {
        var attr = slotToAttr(repr.getHint(classHandle, attrName));
        return (this[attr] == undefined) ? 0 : 1;
      }
    });

  }

};

P6opaque.prototype.createObjConstructor = basicConstructor;
P6opaque.prototype.typeObjectFor = basicTypeObjectFor;

reprs.P6opaque = P6opaque;

class KnowHOWREPR {
  deserializeFinish(obj, data) {
    obj.__name = data.str();
    obj.__attributes = data.variant().array;
    obj.__methods = data.variant();
  }

  serialize(data, obj) {
    data.str(obj.__name);
    data.ref(BOOT.createArray(obj.__attributes));
    data.ref(obj.__methods);
  }

  allocate(STable) {
    var obj = new STable.objConstructor();
    obj.__methods = new Hash();
    obj.__attributes = [];
    obj.__name = '<anon>';
    return obj;
  }
};

KnowHOWREPR.prototype.typeObjectFor = basicTypeObjectFor;
KnowHOWREPR.prototype.createObjConstructor = basicConstructor;



reprs.KnowHOWREPR = KnowHOWREPR;

class KnowHOWAttribute {
  deserializeFinish(obj, data) {
    obj.__name = data.str();
  }

  serialize(data, obj) {
    data.str(obj.__name);
  }
};

KnowHOWAttribute.prototype.createObjConstructor = basicConstructor;
KnowHOWAttribute.prototype.typeObjectFor = basicTypeObjectFor;
KnowHOWAttribute.prototype.allocate = basicAllocate;

reprs.KnowHOWAttribute = KnowHOWAttribute;

class Uninstantiable extends REPR {
  allocate(STable) {
    throw new NQPException('You cannot create an instance of this type (' + STable.debugName + ')');
  }
};
reprs.Uninstantiable = Uninstantiable;

class P6int extends REPR {
  setupSTable(STable) {
    STable.addInternalMethods(class {
      $$setInt(value) {
        this.value = value;
      }

      $$getInt(value) {
        return this.value;
      }

      $$decont_i(value) {
        return this.value;
      }
    });
  }

  compose(STable, reprInfoHash) {
    var integer = reprInfoHash.content.get('integer');
    if (integer) {
      var bits = integer.content.get('bits');
      if (bits instanceof NQPInt) {
        this.bits = bits.value;
      } else {
        throw 'bits to P6int.compose must be a native int';
      }
    }
  }

  deserializeFinish(obj, data) {
    // TODO integers bigger than 32bit
    obj.value = data.varint();
  }

  deserializeInline(data) {
    return data.varint();
  }

  serialize(data, obj) {
    // TODO integers bigger than 32bit
    data.varint(obj.value);
  }

  serializeInline(data, value) {
    // TODO integers bigger than 32bit
    data.varint(value);
  }

  generateBoxingMethods(STable, name) {
    STable.addInternalMethods(class {
      $$setInt(value) {
        this[name] = value;
      }

      $$getInt() {
        return this[name];
      }

      $$decont_i(ctx) {
        return this[name];
      }
    });
  }

  generateFlattenedAccessors(ownerSTable, attrContentSTable, slot) {
    var attr = slotToAttr(slot);
    /* TODO - use actual type instead of NQPInt */
    ownerSTable.addInternalMethod('$$getattr$' + slot, function() {
      return new NQPInt(this[attr]);
    });
  }
};

P6int.prototype.flattenedDefault = '0';
P6int.prototype.boxedPrimitive = 1;
P6int.prototype.flattenSTable = true;


reprs.P6int = P6int;


// TODO:  handle float/bits stuff in compose
class P6num extends REPR {
  setupSTable(STable) {
    STable.addInternalMethods(class {
      $$setNum(value) {
        this.value = value;
      }

      $$getNum() {
        return this.value;
      }

      $$decont_n(value) {
        return this.value;
      }
    });
  }

  serialize(data, obj) {
    data.double(obj.value);
  }

  serializeInline(data, value) {
    data.double(value);
  }

  deserializeFinish(obj, data) {
    obj.value = data.double();
  }

  deserializeInline(data) {
    return data.double();
  }

  generateBoxingMethods(STable, name) {
    STable.addInternalMethods(class {
      $$setNum(value) {
        this[name] = value;
      }

      $$getNum() {
        return this[name];
      }

      $$decont_n(ctx) {
        return this[name];
      }
    });
  }

  generateFlattenedAccessors(ownerSTable, attrContentSTable, slot) {
    var attr = slotToAttr(slot);

    /* TODO wrap object more correctly */

    ownerSTable.addInternalMethod('$$getattr$' + slot, function() {
      return this[attr];
    });
  }
};

P6num.prototype.boxedPrimitive = 2;
P6num.prototype.flattenSTable = true;
P6num.prototype.flattenedDefault = '0';

reprs.P6num = P6num;

class P6str extends REPR {
  setupSTable(STable) {
    STable.addInternalMethods(class {
      $$setStr(value) {
        this.value = value;
      }

      $$getStr() {
        return this.value;
      }

      $$decont_s(value) {
        return this.value;
      }
    });
  }

  serialize(data, obj) {
    data.str(obj.value);
  }

  serializeInline(data, value) {
    data.str(value);
  }

  deserializeFinish(obj, data) {
    obj.value = data.str();
  }

  deserializeInline(data) {
    return data.str();
  }

  generateBoxingMethods(STable, name) {
    STable.addInternalMethods(class {
      $$setStr(value) {
        this[name] = value;
      }

      $$getStr() {
        return this[name];
      }

      $$decont_s(ctx) {
        return this[name];
      }
    });

  }

  generateFlattenedAccessors(ownerSTable, attrContentSTable, slot) {
    var attr = slotToAttr(slot);
    ownerSTable.addInternalMethod('$$getattr$' + slot, function() {
      return this[attr];
    });
  }
};

P6str.prototype.boxedPrimitive = 3;
P6str.prototype.flattenSTable = true;
P6str.prototype.flattenedDefault = 'null_s';


reprs.P6str = P6str;

class NFA extends REPR {
  deserializeFinish(obj, data) {
    /* Read fates. */

    obj.fates = data.variant();

    /* Read number of states. */

    let numStates = data.varint();

    /* Read state graph. */

    obj.states = []

    let edgeCount = [];

    for (let i = 0; i < numStates; i++) {
      edgeCount[i] = data.varint();
    }

    for (let i = 0; i < numStates; i++) {
      obj.states[i] = [];
      for (let j = 0; j < edgeCount[i]; j++) {
        var edge = {act: data.varint(), to: data.varint()};
        switch (edge.act & 0xff) {
          case EDGE_EPSILON:
            break;
          case EDGE_FATE:
          case EDGE_CODEPOINT:
          case EDGE_CODEPOINT_LL:
          case EDGE_CODEPOINT_NEG:
          case EDGE_CHARCLASS:
          case EDGE_CHARCLASS_NEG:
            edge.argI = data.varint();
            break;
          case EDGE_CHARLIST:
          case EDGE_CHARLIST_NEG:
            edge.argS = data.varint();
            break;

          case EDGE_CODEPOINT_I:
          case EDGE_CODEPOINT_I_LL:
          case EDGE_CODEPOINT_I_NEG:
          case EDGE_CHARRANGE:
          case EDGE_CHARRANGE_NEG:
            edge.argLc = data.varint();
            edge.argUc = data.varint();
            break;
          default:
            throw 'NFA deserialization: unknown codepoint type: ' + edge.act;
        }
        obj.states[i].push(edge);
      }
    }
  }

  serialize(cursor, obj) {
    /* Write fates. */

    cursor.ref(obj.fates);

    /* Write number of states. */

    cursor.varint(obj.states.length);

    /* Write state edge list counts. */

    for (let i = 0; i < obj.states.length; i++) {
      cursor.varint(obj.states[i].length);
    }

    /* Write state graph. */

    for (let i = 0; i < obj.states.length; i++) {
      for (let j = 0; j < obj.states[i].length; j++) {
        let edge = obj.states[i][j];

        cursor.varint(edge.act);
        cursor.varint(edge.to);

        switch (edge.act & 0xff) {
          case EDGE_EPSILON:
            break;
          case EDGE_FATE:
          case EDGE_CODEPOINT:
          case EDGE_CODEPOINT_LL:
          case EDGE_CODEPOINT_NEG:
          case EDGE_CHARCLASS:
          case EDGE_CHARCLASS_NEG:
            cursor.varint(edge.argI);
            break;
          case EDGE_CHARLIST:
          case EDGE_CHARLIST_NEG:
            cursor.varint(edge.argS);
            break;
          case EDGE_CODEPOINT_I:
          case EDGE_CODEPOINT_I_LL:
          case EDGE_CODEPOINT_I_NEG:
          case EDGE_CHARRANGE:
          case EDGE_CHARRANGE_NEG:
            cursor.varint(edge.argLc);
            cursor.varint(edge.argUc);
            break;
          default:
            throw 'NFA serialization - unknown codepoint type: ' + edge.act;
        }
      }
    }
  }
}

reprs.NFA = NFA;

// TODO rework VMArray to be more correct
class VMArray extends REPR {

  allocate(STable) {
    var obj = new STable.objConstructor();
    obj.array = [];
    return obj;
  }

  allocateFromArray(STable, array) {
    var obj = new STable.objConstructor();
    obj.array = array;
    return obj;
  }

  setupSTable(STable) {
    STable.addInternalMethods(class {
      $$push(value) {
        if (this._SC !== undefined) this.$$scwb();
        this.array.push(value);
        return value;
      }

      $$push(value) {
        this.array.push(value);
        return value;
      }

      $$atpos(index) {
        var value = this.array[index < 0 ? this.array.length + index : index];
        if (value === undefined) return Null;
        return value;
      }

      /* TODO test how things should be converted */

      $$atpos_s(index) {
        var value = this.array[index < 0 ? this.array.length + index : index];
        if (value === undefined) return null_s;
        return value;
      }

      $$atpos_n(index) {
        var value = this.array[index < 0 ? this.array.length + index : index];
        if (value === undefined) return 0.0;
        return value;
      }

      $$atpos_i(index) {
        var value = this.array[index < 0 ? this.array.length + index : index];
        if (value === undefined) return 0;
        return value;
      }

      $$bindpos(index, value) {
        if (this._SC !== undefined) this.$$scwb();
        return this.array[index < 0 ? this.array.length + index : index] = value;
      }

      $$join(delim) {
        return this.array.join(delim);
      }


      $$pop() {
        var value = this.array.pop();
        if (value === undefined) return Null;
        return value;
      }

      $$shift() {
        var value = this.array.shift();
        if (value === undefined) return Null;
        return value;
      }

      $$unshift(value) {
        this.array.unshift(value);
        return value;
      }

      $$elems() {
        return this.array.length;
      }

      $$existspos(index) {
        if (index < 0) index += this.array.length;
        return this.array.hasOwnProperty(index) ? 1 : 0;
      }

      $$setelems(elems) {
        this.array.length = elems;
      }

      $$numdimensions() {
        return 1;
      }

      $$setdimensions(dimensions) {
        if (dimensions.array.length != 1) {
          throw new NQPException('A dynamic array can only have a single dimension');
        } else {
          this.array.length = dimensions.array[0];
        }
      }

      $$dimensions(dimensions) {
        return BOOT.createArray([this.array.length]);
      }

      $$toArray() {
        return this.array;
      }

      $$iterator() {
        return new Iter(this.array);
      }

      $$numify() {
        return this.array.length;
      }

      $$splice(source, offset, length) {
        // TODO think about the case when the source is not VMArray
        var args = [offset, length];
        for (var i = 0; i < source.array.length; i++) {
          args.push(source.array[i]);
        }
        this.array.splice.apply(this.array, args);
        return this;
      }

      $$clone() {
        var cloned = new STable.objConstructor();
        cloned.array = this.array.slice();
        return cloned;
      }
    });


    var $$atposnd = function(idx) {
      if (idx.array.length != 1) {
        throw new NQPException('A dynamic array can only be indexed with a single dimension');
      }
      var index = idx.array[0];
      var value = this.array[index < 0 ? this.array.length + index : index];
      if (value === undefined) return Null;
      return value;
    };

    var $$bindposnd = function(idx, value) {
      if (idx.array.length != 1) {
        throw new NQPException('A dynamic array can only be indexed with a single dimension');
      }
      var index = idx.array[0];
      return (this.array[index] = value);
    };

    var suffixes = ['', '_s', '_i', '_n'];
    for (let suffix of suffixes) {
      STable.addInternalMethod('$$atposnd' + suffix, $$atposnd);
      STable.addInternalMethod('$$bindposnd' + suffix, $$bindposnd);
    }
  }

  deserializeFinish(obj, data) {
    if (this.type !== Null) {
      console.log('NYI: VMArrays of a type different then null');
    }

    obj.array = [];
    var size = data.varint();
    for (var i = 0; i < size; i++) {
      obj.array[i] = data.variant();
    }
  }


  serialize(cursor, obj) {
    if (this.type !== Null) {
      console.log('NYI: VMArrays of a type different then null');
    }

    cursor.varint(obj.array.length);
    for (var i = 0; i < obj.array.length; i++) {
      cursor.ref(obj.array[i] === undefined ? Null : obj.array[i]);
    }
  }

  deserializeReprData(cursor) {
    this.type = cursor.variant();
  }

  serializeReprData(st, cursor) {
    cursor.ref(this.type);
  }

  deserializeArray(obj, data) {
    if (this.type !== Null) {
      console.log('NYI: VMArrays of a type different then null');
    }
    var size = data.varint();
    for (var i = 0; i < size; i++) {
      obj.array[i] = data.variant();
    }
  }

  compose(STable, reprInfoHash) {
    if (reprInfoHash.content.get('array')) {
      this.type = reprInfoHash.content.get('array').content.get('type') || Null;
    } else {
      this.type = Null;
    }
  }
};

reprs.VMArray = VMArray;


class VMIter {
  deserializeFinish(obj, data) {
    // STUB
    console.log('deserializing VMIter');
  }
};

VMIter.prototype.createObjConstructor = basicConstructor;
VMIter.prototype.typeObjectFor = basicTypeObjectFor;
reprs.VMIter = VMIter;


function makeBI(STable, num) {
  var instance = STable.REPR.allocate(STable);
  instance.$$setBignum(num);
  return instance;
}

function getBI(obj) {
  return obj.$$getBignum();
}

class P6bigint extends REPR {
  setupSTable(STable) {
    STable.addInternalMethods(class {
      $$setInt(value) {
        this.value = bignum(value);
      }

      $$getInt() {
        return this.value.toNumber() | 0;
      }

      $$setBignum(value) {
        this.value = value;
      }

      $$getBignum() {
        return this.value;
      }

      $$decont_i(ctx) {
        return this.value.toNumber() | 0;
      }
    });
  }

  generateFlattenedAccessors(ownerSTable, attrContentSTable, slot) {
    var attr = slotToAttr(slot);

    ownerSTable.addInternalMethod('$$getattr$' + slot, function() {
      var value = this[attr] || bignum(0);
      return makeBI(attrContentSTable, value);
    });

    ownerSTable.addInternalMethod('$$bindattr$' + slot, function(value) {
      this[attr] = getBI(value);
      return value;
    });
  }

  deserializeFinish(obj, data) {
    if (data.varint() == 1) { /* Is it small int? */
      obj.value = bignum(data.varint());
    } else {
      obj.value = bignum(data.str());
    }
  }

  deserializeInline(data) {
    if (data.varint() == 1) { /* Is it small int? */
      return bignum(data.varint());
    } else {
      return bignum(data.str());
    }
  }

  serialize(cursor, obj) {
    var isSmall = 0; /* TODO - check */

    cursor.varint(isSmall);
    if (isSmall) {
      cursor.varint(obj.value.toNumber());
    } else {
      cursor.str(obj.value.toString());
    }
  }

  serializeInline(data, value) {
    var isSmall = 0; /* TODO - check */

    data.varint(isSmall);
    if (isSmall) {
      data.varint(value.toNumber());
    } else {
      data.str(value.toString());
    }
  }

  generateBoxingMethods(STable, name) {
    STable.addInternalMethods(class {
      $$setInt(value) {
        this[name] = bignum(value);
      }

      $$getInt() {
        return this[name].toNumber() | 0;
      }

      $$decont_i(ctx) {
        return this[name].toNumber() | 0;
      }

      $$getBignum() {
        return this[name];
      }

      $$setBignum(num) {
        this[name] = num;
      }
    });
  }
};

P6bigint.prototype.flattenSTable = true;
P6bigint.prototype.flattenedDefault = 'ZERO';


reprs.P6bigint = P6bigint;


/* Stubs */

class NativeCall extends REPR {};
reprs.NativeCall = NativeCall;

class CPointer extends REPR {};
reprs.CPointer = CPointer;

class AsyncTask extends REPR {};
reprs.AsyncTask = AsyncTask;

class ReentrantMutex extends REPR {
  serialize(cursor, obj) {
    /* Nothing to do, we just re-create the lock on deserialization on backend that support them.
     * The JS backend doesn't support concurrency.
     */
  }
};
reprs.ReentrantMutex = ReentrantMutex;

class ConditionVariable extends REPR {};
reprs.ConditionVariable = ConditionVariable;

class Semaphore extends REPR {};
reprs.Semaphore = Semaphore;

class ConcBlockingQueue extends REPR {};
reprs.ConcBlockingQueue = ConcBlockingQueue;

class Decoder extends REPR {};
reprs.Decoder = Decoder;

class MultiDimArray extends REPR {
  allocate(STable) {
    var obj = new STable.objConstructor();
    obj.dimensions = undefined;
    return obj;
  }

  compose(STable, reprInfoHash) {
    var array = reprInfoHash.content.get('array');
    var dimensions = array.content.get('dimensions');

    var type = reprInfoHash.content.get('array').content.get('type');

    if (type) {
      STable.primType = type._STable.REPR.boxedPrimitive;
    } else {
      STable.primType = 0;
    }

    STable.type = type || Null;

    if (dimensions instanceof NQPInt) {
      dimensions = dimensions.value;
      if (dimensions === 0) {
        throw new NQPException('MultiDimArray REPR must be composed with at least 1 dimension');
      }

    } else {
      throw 'dimensions to MultiDimArray.compose must be a native int';
    }

    //  console.log('dimensions', dimensions);
    STable.dimensions = dimensions;
  }



  setupSTable(STable) {
    STable.addInternalMethods(class {
      $$numdimensions(value) {
        if (this.typeObject_) {
          throw new NQPException('Cannot get number of dimensions of a type object');
        }
        return STable.dimensions;
      }

      $$clone() {
        var clone = new this._STable.objConstructor();
        clone.storage = this.storage.slice();
        clone.dimensions = this.dimensions;
        return clone;
      }

      $$dimensions() {
        if (this.typeObject_) {
          throw new NQPException('Cannot get dimensions of a type object');
        }
        return BOOT.createArray(this.dimensions);
      }

      $$setdimensions(value) {
        if (value.array.length != STable.dimensions) {
          throw new NQPException('Array type of ' + STable.dimensions + ' dimensions cannot be intialized with ' + value.length + ' dimensions');
        } else if (this.dimensions) {
          throw new NQPException('Can only set dimensions once');
        }
        this.storage = [];
        return (this.dimensions = value.array);
      }

      $$pop() {
        throw new NQPException('Cannot pop a fixed dimension array');
      }

      $$shift() {
        throw new NQPException('Cannot shift a fixed dimension array');
      }

      $$unshift(value) {
        throw new NQPException('Cannot unshift a fixed dimension array');
      }

      $$push(value) {
        throw new NQPException('Cannot push a fixed dimension array');
      }

      $$splice(value) {
        throw new NQPException('Cannot splice a fixed dimension array');
      }

      $$calculateIndex(idx, value) {
        idx = idx.array;
        if (idx.length != STable.dimensions) {
          throw new NQPException('Cannot access ' + STable.dimensions + ' dimension array with ' + idx.length + ' indices');
        }

        for (var i = 0; i < idx.length; i++) {
          if (idx[i] < 0 || idx[i] >= this.dimensions[i]) {
            throw new NQPException('Index ' + idx[i] + ' for dimension ' + (i + 1) + ' out of range (must be 0..' + this.dimensions[i] + ')');
          }
        }
        var calculatedIdx = 0;
        for (var i = 0; i < idx.length; i++) {
          calculatedIdx = calculatedIdx * this.dimensions[i] + idx[i];
        }
        return calculatedIdx;
      }

      $$atposnd(idx) {
        if (STable.primType != 0) throw new NQPException('wrong type');
        return this.storage[this.$$calculateIndex(idx)];
      }

      $$bindposnd(idx, value) {
        if (STable.primType != 0) throw new NQPException('wrong type: ' + STable.primType);
        return (this.storage[this.$$calculateIndex(idx)] = value);
      }

      $$atposnd_i(idx) {
        if (STable.primType != 1) throw new NQPException('wrong type: ' + STable.primType);
        return this.storage[this.$$calculateIndex(idx)];
      }

      $$bindposnd_i(idx, value) {
        if (STable.primType != 1) throw new NQPException('wrong type' + STable.primType);
        return (this.storage[this.$$calculateIndex(idx)] = value);
      }

      $$atposnd_n(idx) {
        if (STable.primType != 2) throw new NQPException('wrong type');
        return this.storage[this.$$calculateIndex(idx)];
      }

      $$bindposnd_n(idx, value) {
        if (STable.primType != 2) throw new NQPException('wrong type');
        return (this.storage[this.$$calculateIndex(idx)] = value);
      }

      $$atposnd_s(idx) {
        if (STable.primType != 3) throw new NQPException('wrong type');
        return this.storage[this.$$calculateIndex(idx)];
      }

      $$bindposnd_s(idx, value) {
        if (STable.primType != 3) throw new NQPException('wrong type');
        return (this.storage[this.$$calculateIndex(idx)] = value);
      }

      // TODO optimize and avoid creating a temporary array
      $$bindpos(index, value) {
        return this.$$bindposnd(BOOT.createArray([index]), value);
      }

      $$setelems(elems) {
        this.$$setdimensions(BOOT.createArray([elems]));
      }

      $$elems(elems) {
        return this.dimensions[0];
      }

      $$atpos(index) {
        return this.$$atposnd(BOOT.createArray([index]));
      }
    });
  }

  serializeReprData(st, cursor) {
    if (st.dimensions) {
      cursor.varint(st.dimensions);
      cursor.ref(st.type);
    } else {
      cursor.varint(0);
    }
  }

  deserializeReprData(cursor, STable) {
    var dims = cursor.varint();
    if (dims > 0) {
      STable.dimensions = dims;
      STable.type = cursor.variant();
      STable.primType = STable.type !== Null ? STable.type._STable.REPR.boxedPrimitive : 0;
    }
  }

  valuesSize(obj) {
    var size = 1;
    for (var i = 0; i < obj.dimensions.length; i++) {
      size = size * obj.dimensions[i];
    }
    return size;
  }

  serialize(cursor, obj) {
    for (var i = 0; i < obj._STable.dimensions; i++) {
      cursor.varint(obj.dimensions[i]);
    }
    var size = this.valuesSize(obj);
    for (var i = 0; i < size; i++) {
      switch (obj._STable.primType) {
        case 0:
          cursor.ref(obj.storage[i]);
          break;
        case 1:
          cursor.varint(obj.storage[i]);
          break;
        case 2:
          cursor.double(obj.storage[i]);
          break;
        case 3:
          cursor.str(obj.storage[i]);
          break;
      }
    }
  }

  deserializeFinish(obj, data) {
    obj.dimensions = [];
    for (var i = 0; i < obj._STable.dimensions; i++) {
      obj.dimensions[i] = data.varint();
    }
    var size = this.valuesSize(obj);
    obj.storage = [];
    for (var i = 0; i < size; i++) {
      switch (obj._STable.primType) {
        case 0:
          obj.storage[i] = data.variant();
          break;
        case 1:
          obj.storage[i] = data.varint();
          break;
        case 2:
          obj.storage[i] = data.double();
          break;
        case 3:
          obj.storage[i] = data.str();
          break;
      }
    }
  }

};

reprs.MultiDimArray = MultiDimArray;

class VMException extends REPR {
  setupSTable(STable) {

    STable.addInternalMethods(class {
      $$getStr() {
        return this.message;
      }
    });
  }
};


reprs.VMException = VMException;


class NativeRef extends REPR {
  compose(STable, reprInfoHash) {
    var nativeref = reprInfoHash.content.get('nativeref').content;
    var type = nativeref.get('type');
    this.primitiveType = type._STable.REPR.boxedPrimitive;
    this.refkind = nativeref.get('refkind');
  }

  serializeReprData(st, cursor) {
    cursor.varint(this.primitiveType || 0);
    cursor.varint(0);
  }

  deserializeReprData(cursor, STable) {
    this.primitiveType = cursor.varint();
    cursor.varint();
  }
};
reprs.NativeRef = NativeRef;

var ID = 0;
for (var name in reprs) {
  module.exports[name] = reprs[name];
  reprs[name].prototype.ID = ID;
  reprs[name].prototype.name = name;
  reprById[ID] = reprs[name];
  if (reprs[name].prototype.flattenedDefault) {
    reprs[name].prototype.flattenedDefaultObj = eval(reprs[name].prototype.flattenedDefault);
  }
  ID++;
}
