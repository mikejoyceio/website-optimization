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
      joinTo: 
      	'js/index.js': /^app\/js\/index\//
      	'js/pizza.js': /^app\/js\/pizza\//		
    stylesheets:
      joinTo: 
      	'css/style.css': /^app\/css\/style\//
      	'css/print.css': /^app\/css\/print\//	
      	'css/bootstrap.css': /^app\/css\/bootstrap\//
      	'css/pizza.css': /^app\/css\/pizza\//		