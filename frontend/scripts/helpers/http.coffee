axios = require 'axios'

methods = ['get', 'head', 'post', 'put', 'patch', 'delete']

http = ->
  axios arguments...

methods.forEach (method) ->
  http[method] = ->
    promise = axios[method] arguments...
    http.promises.push promise if http.recording
    promise

http.interceptRequest = (fn) ->
  axios.interceptors.request.use fn
  -> axios.interceptors.request.eject fn

http.interceptResponse = (fn) ->
  axios.interceptors.response.use fn
  -> axios.interceptors.response.eject fn

http.recordRequests = (fn) ->
  http.recording = true
  http.promises = []
  result = fn()
  http.recording = false
  { result, promises: http.promises }

module.exports = http
