var path = require('path');

var config = {
  app_name: ['Appy'],
  license_key: process.env.TOP_NEW_RELIC_LICENSE_KEY,
  logging: {
    level: 'info',
    filepath: path.join(__dirname, '../log/newrelic_prerender.log')
  },
  browser_monitoring: {
    enable: process.env.TOP_ENV == 'production'
  }
};

module.exports.config = config;
