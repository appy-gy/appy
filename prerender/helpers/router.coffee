ReduxReactRouterServer = require 'redux-react-router/server'
routes = require '../../frontend/scripts/routes'

{reduxReactRouter} = ReduxReactRouterServer

router = reduxReactRouter { routes }

module.exports = router
