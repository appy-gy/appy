ReduxRouterServer = require 'redux-router/server'
routes = require '../../frontend/scripts/routes'

{reduxReactRouter} = ReduxRouterServer

router = reduxReactRouter { routes }

module.exports = router
