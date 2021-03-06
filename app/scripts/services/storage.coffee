'use strict';

angular.module('chromodoroApp')
  .factory 'storage', ['$q', ($q) ->
    {
      # Returns a $q promise that resolves or rejects, unless passed a callback
      fetch: (key, cb) ->
        d = undefined
        if (not cb?)
          d = $q.defer()
          cb = (value) ->
            if chrome.runtime.lastError?
              d.reject(chrome.runtime.lastError)
            else
              d.resolve(value)

        chrome.storage.local.get(key, cb)
        return d

      # Returns a $q promise that resolves or rejects, unless passed a callback
      store: (changes, cb) ->
        d = undefined
        if (not cb?)
          d = $q.defer()
          cb = () ->
            if chrome.runtime.lastError?
              d.reject(chrome.runtime.lastError)
            else
              d.resolve()

        chrome.storage.local.set(changes, cb)
        return d
    }
  ]
