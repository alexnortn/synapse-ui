



THREE 	  = require "three"
Trackball = require "three-trackballcontrols"

#  threejs globals
camera 		= ''
controls 	= ''
scene 		= ''
renderer 	= ''
geometry 	= ''
material 	= ''
mesh 		= ''

setup = (_layer, _canvas) =>
	_width  = _layer.width
	_height = _layer.height
	_x      = _layer.x
	_y      = _layer.y

	camera = new THREE.PerspectiveCamera( 75, _width / _height, 1, 1000 );
	camera.position.z = 500;

	scene = new THREE.Scene();

	geometry = new THREE.IcosahedronGeometry(200, 1 );
	material =  new THREE.MeshBasicMaterial(
		{
	        color: 0xfff999fff,
	        wireframe: true,  
	        wireframelinewidth:8
	    }
	)
	
	mesh = new THREE.Mesh(geometry, material);
	scene.add( mesh );

	renderer = new THREE.WebGLRenderer({ canvas: _canvas, antialias: true, alpha:true });
	renderer.setSize(_width, _height);

	controls = new Trackball( camera );
	  

animate = () =>
	window.requestAnimationFrame( animate );

	mesh.rotation.x = Date.now() * 0.00001;
	mesh.rotation.y = Date.now() * 0.00001; 
	mesh.position.y += 0.0005;
	mesh.position.z += 0.05;  

	controls.update(); # Trackball Update

	renderer.render( scene, camera);


# setup();
# animate();
exports.setup = setup
exports.animate = animate

# exports = {
# 	setup: (_layer) =>
# 		return setup(_layer);
# 	animate: (x) =>
# 		return animate();
# }

# exports.setup = setup()
# exports.animate = animate()
























