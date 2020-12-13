package ch09;

import externs.Ply.PLYLoader;
import externs.Ply.Loader;
import externs.Ogl.Geometry;
import externs.Ogl.Program;
import externs.Ogl.Vec3;
import utils.DirectionalLight;
import externs.Ogl.Mesh;
import utils.OglBase;
import js.Browser;

abstract class LightModelBase extends OglBase {
	private var program:Program;
	private var mesh:Mesh;
	private var light:DirectionalLight;

	public function new() {
		super();
		light = new DirectionalLight();
		light.intensity = 1.0;
		light.color = new Vec3(1, 1, 1);
		light.direction = new Vec3(0, -1, 0);
	}

	override private function setup():Void {
		super.setup();
		Loader.load(getModel(), PLYLoader, {}).then(r -> {
			program = createShader();
			final geometry = new Geometry(gl, {
				position: {size: r.attributes.POSITION.size, data: r.attributes.POSITION.value},
				uv: {size: r.attributes.TEXCOORD_0.size, data: r.attributes.TEXCOORD_0.value},
				normal: {size: r.attributes.NORMAL.size, data: r.attributes.NORMAL.value},
				index: {size: r.indices.size, data: r.indices.value},
			});

			mesh = new Mesh(gl, {geometry: geometry, program: program});
			mesh.rotation.x = Math.PI * 0.75;
			mesh.setParent(scene);

			Browser.window.requestAnimationFrame(onFrame);
		});
    }

	override public function onFrame(dt:Float):Void {
		super.onFrame(dt);
		rotateMesh(dt);
    }
    
	abstract private function createShader(): Program;
	private function getModel() {
		return Webpack.require("../../assets/torus.ply");
	}
	private function rotateMesh(dt:Float) {
		mesh.rotation.x += 0.01;
		mesh.rotation.y += 0.01;
		mesh.rotation.z += 0.01;
	}
}
