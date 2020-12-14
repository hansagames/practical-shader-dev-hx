package ch10;

import externs.Ogl.TextureProps;
import js.Browser;
import externs.Ply.PLYLoader;
import externs.Ply.Loader;
import externs.Ogl.Vec2;
import js.lib.Float32Array;
import externs.Ply.PlyModel;
import externs.Ply.Attributes;
import externs.Ogl.Mesh;
import externs.Ogl.Geometry;
import utils.OglBase;
import js.html.Image;
import externs.Ogl.Texture;
import externs.Ogl.Program;
import externs.Ogl.Vec3;
import utils.DirectionalLight;

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
			final geometry = new Geometry(gl, {
				position: {size: r.attributes.POSITION.size, data: r.attributes.POSITION.value},
				uv: {size: r.attributes.TEXCOORD_0.size, data: r.attributes.TEXCOORD_0.value},
				normal: {size: r.attributes.NORMAL.size, data: r.attributes.NORMAL.value},
				index: {size: r.indices.size, data: r.indices.value},
				tangent: {size: r.attributes.NORMAL.size, data: calculateTangents(r)},
			});

			mesh = new Mesh(gl, {geometry: geometry, program: program});
			mesh.rotation.x = Math.PI * 0.75;
			mesh.setParent(scene);

			Browser.window.requestAnimationFrame(onFrame);
		});
	}

	abstract private function createShader():Program;

	abstract function getModel(): String;

	private function loadTexture(path:String, ?props: TextureProps):Texture {
		final texture = new Texture(gl, props);
		final img = new Image();
		img.src = path;
		img.onload = () -> texture.image = img;
		return texture;
	}

	private function calculateTangents(model:PlyModel):Float32Array {
		final tangents:Array<Vec3> = [];
		final indexCount:Int = Std.int(model.indices.value.length / model.indices.size);
		final uvs = model.attributes.TEXCOORD_0.value;
		final vertices = model.attributes.POSITION.value;
		final indices = model.indices.value;
		for (i in 0...indexCount - 2) {
			if (i % 3 == 0) {
				final v0:Vec3 = new Vec3(vertices[indices[i]], vertices[indices[i + 1]], vertices[indices[i + 2]]);
				final v1:Vec3 = new Vec3(vertices[indices[i + 3]], vertices[indices[i + 4]], vertices[indices[i + 5]]);
				final v2:Vec3 = new Vec3(vertices[indices[i + 6]], vertices[indices[i + 7]], vertices[indices[i + 8]]);

				final uv0:Vec2 = new Vec2(uvs[indices[i]], uvs[indices[i + 1]]);
				final uv1:Vec2 = new Vec2(uvs[indices[i + 2]], uvs[indices[i + 3]]);
				final uv2:Vec2 = new Vec2(uvs[indices[i + 4]], uvs[indices[i + 5]]);

				final edge1 = v1.clone().sub(v0);
				final edge2 = v2.clone().sub(v0);
				final dUV1 = uv1.clone().sub(uv0);
				final dUV2 = uv2.clone().sub(uv0);

				final f = 1.0 / (dUV1.x * dUV2.y - dUV2.x * dUV1.y);

				final tan:Vec3 = new Vec3();
				tan.x = f * (dUV2.y * edge1.x - dUV1.y * edge2.x);
				tan.y = f * (dUV2.y * edge1.y - dUV1.y * edge2.y);
				tan.z = f * (dUV2.y * edge1.z - dUV1.y * edge2.z);
				tan.normalize();

				tangents[indices[i]] = tan.clone();
				tangents[indices[i + 1]] = tan.clone();
				tangents[indices[i + 2]] = tan.clone();
			}
		}
		final result = new Float32Array(tangents.length * 3);
		for (i in 0...tangents.length) {
			final t = tangents[i];
			result[i] = t.x;
			result[i + 1] = t.y;
			result[i + 2] = t.z;
        }
		return result;
	}
}
