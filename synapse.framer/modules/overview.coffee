



THREE 	  = require "three"
Trackball = require "three-trackballcontrols"
OBJLoader = require('three-obj-loader')

OBJLoader(THREE);

#  threejs globals
camera 		= ''
controls 	= ''
scene 		= ''
renderer 	= ''
geometry 	= ''
material 	= ''
mesh 		= ''

setup = (_layer, _canvas) ->
	_width  = _layer.width
	_height = _layer.height
	_x      = _layer.x
	_y      = _layer.y

	camera = new THREE.PerspectiveCamera( 75, _width / _height, 1, 1000 );
	camera.position.z = 500;

	scene = new THREE.Scene();

	# Lights
	ambient = new THREE.AmbientLight( 0x101030 );
	scene.add( ambient );
	
	directionalLight = new THREE.DirectionalLight( 0xffeedd );
	directionalLight.position.set( 0, 0, 1 );
	scene.add( directionalLight );

	renderer = new THREE.WebGLRenderer({ canvas: _canvas, antialias: true, alpha:true });
	renderer.setSize(_width, _height);

	controls = new Trackball( camera );

	material = new THREE.MeshPhongMaterial()

	setupLoader(material)


# Setup Texture Loader
setupLoader = (material) ->
	manager = new THREE.LoadingManager();
	manager.onProgress = ( item, loaded, total ) ->
		console.log( item, loaded, total );


	loader = new THREE.OBJLoader( manager );
	loader.load( 'images/70014.obj', ( object ) ->

		object.traverse( ( child ) ->
	        if ( child instanceof THREE.Mesh )
	            child.material = material;
	    );

		mesh = object
		scene.add( object );
	);
	  

animate = () ->
	window.requestAnimationFrame( animate );

	if (mesh)
		mesh.rotation.x = Date.now() * 0.00005;
		mesh.rotation.y = Date.now() * 0.00005; 
	# mesh.position.y += 0.0005;
	# mesh.position.z += 0.05;  

	controls.update(); # Trackball Update

	renderer.render( scene, camera);


exports.setup = setup
exports.animate = animate
























