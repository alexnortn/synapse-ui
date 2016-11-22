



THREE 	  = require "three"
Trackball = require "three-trackballcontrols"

#  threejs globals
camera 		= ''
scene 		= ''
renderer 	= ''
geometry 	= ''
material 	= ''
mesh 		= ''

init = (_layer, _canvas) =>
	_width  = _layer.width
	_height = _layer.height
	_x      = _layer.x
	_y      = _layer.y

	camera = new THREE.PerspectiveCamera( 75, _width / _height, 1, 1000 );
	camera.position.z = 500;

	scene = new THREE.Scene();

	geometry = new THREE.IcosahedronGeometry(200, 1 );
	material =  new THREE.MeshBasicMaterial({
	                                        color: 0xfff999fff,
	                                        wireframe: true,  
	                                        wireframelinewidth:8 })
	
	mesh = new THREE.Mesh(geometry, material);
	scene.add( mesh );

	renderer = new THREE.WebGLRenderer({ canvas: _canvas, antialias: true, alpha:true });
	renderer.setSize(_width, _height);

	renderer.setSize( window.innerWidth, window.innerHeight ) ;

	# document.body.appendChild( renderer.domElement ) ;
  

animation = () =>
	window.requestAnimationFrame( animation );

	mesh.rotation.x = Date.now() * 0.00005;
	mesh.rotation.y = Date.now() * 0.0001; 
	mesh.position.y += 0.0005;
	mesh.position.z += 0.05;  

	renderer.render( scene, camera);


# init();
# animation();
exports.init = init
exports.animation = animation

# exports = {
# 	init: (_layer) =>
# 		return init(_layer);
# 	animation: (x) =>
# 		return animation();
# }

# exports.init = init()
# exports.animation = animation()
























