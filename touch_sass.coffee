touch = require 'touch'
watch = require 'node-watch'

skipNext = false

watch 'frontend/styles', (filename) ->
  return skipNext = false if skipNext

  console.log "#{filename} changed"
  skipNext = true
  touch.sync 'frontend/styles/app.sass'
