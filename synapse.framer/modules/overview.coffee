# File: modules/npm.coffee 

# Interface for requiring npm files in FramerStudio
THREE = require "three"
exports.THREE = THREE

Trackball = require("npm").trackball

# 3D Navigation
trackball = require "three-trackballcontrols"
exports.trackball = trackball

#  threejs globals
camera 		= ''
scene 		= ''
renderer 	= ''
geometry 	= ''
material 	= ''
mesh 		= ''

init = (layer) =>
	_width  = layer.width
	_height = layer.height
	_x      = layer.x
	_y      = layer.y

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

	renderer = new THREE.WebGLRenderer();
	renderer.setSize( window.innerWidth, window.innerHeight ) ;

	document.body.appendChild( renderer.domElement ) ;
  

animation = () =>
	window.requestAnimationFrame( animation );

	mesh.rotation.x = Date.now() * 0.00005;
	mesh.rotation.y = Date.now() * 0.0001; 
	mesh.position.y += 0.0005;
	mesh.position.z += 0.05;  

	renderer.render( scene, camera);


# init();
# animation();






# overviewCanvas = document.createElement "canvas"
# overviewCanvas.setAttribute("width","750px")
# overviewCanvas.setAttribute("height","500px")
# overviewCanvas.setAttribute("style","border: 2px solid black; background: #CCC")

# container = new Layer
#     height: 1334
#     width: 750
#     backgroundColor: "white"

# container._element.appendChild(overviewCanvas)
# ctx = overviewCanvas.getContext "2d"

# ctx.fillStyle = "blue"
# ctx.fillRect(0, 0, 50, 50)

























