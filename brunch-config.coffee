exports.config = 
  conventions:
    assets: /^app\/assets\//
  modules:
    definition: false
    wrapper: false
  paths:
    public: 'public'
  files:
    javascripts:
      joinTo: 'js/app.js': /^app\/js\//		
    stylesheets:
      joinTo: 
      	'css/style.css': /^app\/css\/style\//
      	'css/print.css': /^app\/css\/print\//		