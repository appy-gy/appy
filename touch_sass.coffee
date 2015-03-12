touch = require 'touch'
watch = require 'node-watch'

skipNext = false

watch 'src/styles', (filename) ->
  return skipNext = false if skipNext

  console.log "#{filename} changed"
  skipNext = true
  touch.sync 'src/styles/app.sass'
