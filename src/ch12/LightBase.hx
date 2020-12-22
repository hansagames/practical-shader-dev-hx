package ch12;

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
import utils.CreatePLYGeometry.createPLYGeometry;

abstract class LightBase extends OglBase {
	public function new() {
		super();
	}

	override private function setup():Void {
		super.setup();
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
