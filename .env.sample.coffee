env = process.env.NODE_ENV ||= 'development'

backend =
  development: 'http://127.0.0.1:3000'
  production: ''

env =
  TOP_ENV: env
  TOP_BACKEND_HOST: backend[env]
  WEBPACK_HOST: '127.0.0.1'
  WEBPACK_PORT: 8000

module.exports = env
