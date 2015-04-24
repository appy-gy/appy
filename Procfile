api: bundle exec rails s -b 0.0.0.0
dev-server: ./node_modules/.bin/coffee webpack_dev_server.coffee
touch-sass: ./node_modules/.bin/coffee touch_sass.coffee
prerender: ./node_modules/.bin/nodemon prerender/app.coffee -w prerender -w frontend -e js,coffee,cjsx,jade
proxy: rackup proxy.ru -o 0.0.0.0
