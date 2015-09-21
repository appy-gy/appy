var path = require('path');

var config = {
  app_name: ['Appy'],
  license_key: process.env.TOP_NEW_RELIC_LICENSE_KEY,
  agent_enabled: process.env.TOP_ENV == 'production',
  logging: {
    level: 'info',
    filepath: path.join(__dirname, '../log/newrelic_prerender.log')
  },
};

module.exports.config = config;
