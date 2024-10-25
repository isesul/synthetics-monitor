module.exports = {
  params: {
    url: process.env.TARGET_URL || 'https://www.elastic.co'
  },
  playwright: {
    chromium: {
      headless: true,
      ignore_https_errors: true
    }
  },
  monitor: {
    schedule: process.env.MONITOR_SCHEDULE || '@hourly',
    locations: ['default']
  }
}

