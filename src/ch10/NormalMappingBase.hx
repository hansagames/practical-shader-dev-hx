package ch10;

import js.Browser;
import externs.Ply.PLYLoader;
import externs.Ply.Loader;
import externs.Ogl.Mesh;
import utils.OglBase;
import externs.Ogl.Program;
import externs.Ogl.Vec3;
import utils.DirectionalLight;
import utils.CreatePLYGeometry.createPLYGeometry;

abstract class NormalMappingBase extends OglBase {
	private var program:Program;
	private var mesh:Mesh;
	private var light:DirectionalLight;

	public function new() {
		super();
		light = new DirectionalLight();
		light.intensity = 1.0;
		light.color = new Vec3(1, 1, 1);
		light.direction = new Vec3(0, -1, 0);
		camera.position.set(0, 0, 3);
	}

	override private function setup():Void {
		super.setup();
		Loader.load(getModel(), PLYLoader, {}).then(r -> {
			program = createShader();
			final geometry = createPLYGeometry(gl, r);

			mesh = new Mesh(gl, {geometry: geometry, program: program});
			mesh.rotation.x = Math.PI * 0.75;
			mesh.setParent(scene);

			Browser.window.requestAnimationFrame(onFrame);
		});
	}

	abstract private function createShader():Program;

	abstract function getModel(): String;
}
