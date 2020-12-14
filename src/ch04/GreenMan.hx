package ch04;

import VectorMath.Vec2;
import VectorMath.Vec4;
import VectorMath.Vec3;
import types.Types.IShader;
import utils.Mesh3D;
import utils.BaseOfApp;
import utils.Material;
import types.Types.Mesh;


class GreenMan extends BaseOfApp {
	private var charMesh:Mesh;
	private var shader:IShader;

	public function new() {
		super();
	}

	override private function setup():Void {
		super.setup();
		shader = new Material(ctx);
		shader.load(
			Webpack.require("./shaders/green-man.vert.glsl"),
			Webpack.require("./shaders/green-man.frag.glsl")
		);
		shader.setUniformTexture("greenMan", Webpack.require("../../original/ch4/Assets/alien.png"), 0);
		charMesh = new Mesh3D(ctx, shader.program);
		buildMesh(charMesh, 0.25, 0.5, new Vec3(0, 0.15, 0));
		charMesh.build();
	}
	override public function draw(delta:Float):Void {
		super.draw(delta);
		shader.begin();
		charMesh.draw();
		shader.end();
	}
	private function buildMesh(mesh: Mesh, width: Float, heigh: Float, position: Vec3): Void {
		final verts: Array<Float> = [
			-width + position.x, -heigh + position.y, position.z,
			-width + position.x, heigh + position.y, position.z,
			width + position.x, heigh + position.y, position.z,
			width + position.x, -heigh + position.y, position.z
		];
		final uv: Array<Int> = [
			0, 0, 0,
			1, 1, 1,
			1, 1, 0
		];

		final inidicies: Array<Float> = [
			0, 1, 2, 2, 3, 0
		];

		for(i in 0...4) {
			final idx = i * 3;
			final uvIdx = i * 2;

			mesh.addVertex(new Vec3(verts[idx], verts[idx + 1], verts[idx +2]));
			mesh.addTexCoord(new Vec2(uv[uvIdx], uv[uvIdx + 2]));
		}
		mesh.addIndicies(inidicies);
	}
}
