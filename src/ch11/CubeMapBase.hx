package ch11;

import js.html.Image;
import js.lib.Promise;
import utils.LoadImage.loadImage;
import externs.Ogl.Texture;
import js.html.webgl.WebGL2RenderingContext;
import externs.Ogl.GL;
import js.Browser;
import externs.Ply.PLYLoader;
import externs.Ply.Loader;
import externs.Ogl.Mesh;
import utils.OglBase;
import externs.Ogl.Program;
import externs.Ogl.Vec3;
import utils.DirectionalLight;
import utils.CreatePLYGeometry.createPLYGeometry;

abstract class CubeMapBase extends OglBase {
	private var light:DirectionalLight;
	public function new() {
		super();
	}

	override private function setup():Void {
		super.setup();
		light = new DirectionalLight();
		light.intensity = 1.0;
		light.color = new Vec3(1, 1, 1);
		light.direction = new Vec3(0, -1, 0);
		camera.position.set(0, 0, 3);
		Browser.window.requestAnimationFrame(onFrame);
	}

	private function loadModel(path: String, shader: Program, ?onLoaded: (mesh: Mesh) -> Void) {
		Loader.load(path, PLYLoader, {}).then(r -> {
			final geometry = createPLYGeometry(gl, r);
			final mesh = new Mesh(gl, {geometry: geometry, program: shader});
			mesh.setParent(scene);
			if (onLoaded != null) {
				onLoaded(mesh);
			}
		});
	}
	private function createCubeMapTexture(gl: GL, images: Array<String>): Texture {
		final texture = new Texture(gl, {
			target: WebGL2RenderingContext.TEXTURE_CUBE_MAP,
		});
		final imagesToLoad: Array<Promise<Image>> = [];
		for(path in images) {
			imagesToLoad.push(loadImage(path));
		}
		Promise.all(imagesToLoad).then((images: Array<Image>) -> {
			texture.image = images;
		});
		return texture;
	}
}
