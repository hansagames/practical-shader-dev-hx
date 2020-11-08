package ch04;

import VectorMath.Vec2;
import VectorMath.Vec4;
import VectorMath.Vec3;
import types.Types.IShader;
import utils.Mesh3D;
import utils.BaseOfApp;
import utils.Material;
import types.Types.Mesh;


class DepthTest extends BaseOfApp {
	private var charMesh:Mesh;
	private var charShader:IShader;
	private var bgMesh:Mesh;
	private var bgShader:IShader;
	public function new() {
		super();
	}

	override private function setup():Void {
		super.setup();
		bgShader = new Material(ctx);
		bgShader.load(
			Webpack.require("./shaders/bg.vert.glsl"),
			Webpack.require("./shaders/bg.frag.glsl")
		);
		bgShader.setUniformTexture("bg", Webpack.require("../../assets/forest.png"), 1);
		charShader = new Material(ctx);
		charShader.load(
			Webpack.require("./shaders/green-man.vert.glsl"),
			Webpack.require("./shaders/green-man.frag.glsl")
		);
		charShader.setUniformTexture("greenMan", Webpack.require("../../assets/alien.png"), 0);
		charMesh = new Mesh3D(ctx, charShader.program);
		buildMesh(charMesh, 0.05, 0.1, new Vec3(0, 0.15, 0));
		charMesh.build();
		bgMesh = new Mesh3D(ctx, bgShader.program);
		buildMesh(bgMesh, 1, 1, new Vec3(0, 0, 0.5));
		bgMesh.build();
	}
	override public function draw(delta:Float):Void {
		super.draw(delta);
		charShader.begin();
		charMesh.draw();
		charShader.end();
		bgShader.begin();
		bgMesh.draw();
		bgShader.end();
	}
	private function buildMesh(mesh: Mesh, width: Float, height: Float, position: Vec3): Void {
		final verts: Array<Float> = [
			-width + position.x, -height + position.y, position.z,
			-width + position.x, height + position.y, position.z,
			width + position.x, height + position.y, position.z,
			width + position.x, -height + position.y, position.z
		];
		final uv: Array<Int> = [
			0, 0,
			0, 1,
			1, 1,
			1, 0
		];

		for(i in 0...4) {
			final idx = i * 3;
			final uvIdx = i * 2;

			mesh.addVertex(new Vec3(verts[idx], verts[idx + 1], verts[idx + 2]));
			mesh.addTexCoord(new Vec2(uv[uvIdx], uv[uvIdx + 1]));
		}
		mesh.addIndicies([
			0, 1, 2, 2, 3, 0
		]);
	}
}
