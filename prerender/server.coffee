require 'coffee-react/register'

_ = require 'lodash'
path = require 'path'
express = require 'express'
setup = require './setup'
localsMerger = require './middlewares/locals_merger'
marty = require './middlewares/marty'

setup()

port = _.parseInt _.last process.env.TOP_PRERENDER_HOST.split(':')

app = express()

app.set 'view engine', 'jade'
app.set 'views', path.join(__dirname, 'views')

app.use localsMerger()
app.use marty()

app.listen port
