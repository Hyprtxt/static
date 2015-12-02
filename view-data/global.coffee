module.exports =
  title: 'Hyprtxt Static'
  javascripts: [
    '/js/jquery/jquery.min.js'
    '/js/bootstrap/util.js'
    '/js/bootstrap/collapse.js'
    '/js/bootstrap/dropdown.js'
    '/js/script.js'
  ]
  stylesheets: [
    '/css/style.css'
  ]
  navbarBrand:
    title: 'Hyprtxt Static'
    link: '/'
  navigation: [
    title: 'Test Page'
    link: '/test'
  ,
    title: 'Another Link'
    link: '#somewhere'
  ]
  timestamp: new Date()
  env: process.env.NODE_ENV
