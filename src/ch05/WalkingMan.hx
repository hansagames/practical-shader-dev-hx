package ch05;

import VectorMath.Mat4;
import js.lib.Float32Array;
import utils.Transformation.scale;
import utils.Transformation.rotate;
import utils.Transformation.translate;
import VectorMath.log;
import js.html.KeyboardEvent;
import js.Browser;
import js.html.webgl.RenderingContext;
import VectorMath.Vec2;
import VectorMath.Vec4;
import VectorMath.Vec3;
import types.Types.IShader;
import utils.Mesh3D;
import utils.BaseOfApp;
import utils.Material;
import types.Types.Mesh;


class WalkingMan extends BaseOfApp {
	private var charMesh:Mesh;
	private var charShader:IShader;
	private var bgMesh:Mesh;
	private var bgShader:IShader;
	private var cloudMesh:Mesh;
	private var cloudShader:IShader;
	private var sunMesh:Mesh;
	private var sunShader:IShader;
	private var frame: Float = 0.0;
	private var walkRight: Bool;
	private var charPos: Vec3;
	public function new() {
		super();
		charPos = new Vec3(0, 0, 0);
		Browser.window.addEventListener("keydown", onPress);
		Browser.window.addEventListener("keyup", onRelease);
	}

	override private function setup():Void {
		super.setup();
		bgShader = new Material(ctx);
		bgShader.load(
			Webpack.require("./shaders/bg.vert.glsl"),
			Webpack.require("./shaders/bg.frag.glsl")
		);
		bgShader.setUniformTexture("bg", Webpack.require("../../original/ch5/Assets/forest.png"), 1);
		charShader = new Material(ctx);
		charShader.load(
			Webpack.require("./shaders/spriteSheet.vert.glsl"),
			Webpack.require("./shaders/green-man.frag.glsl")
		);
		charShader.setUniformTexture("greenMan", Webpack.require("../../original/ch5/1_WalkingCharacter/bin/data/walk_sheet.png"), 0, 0);
		cloudShader = new Material(ctx);
		cloudShader.load(
			Webpack.require("./shaders/cloud.vert.glsl"),
			Webpack.require("./shaders/cloud.frag.glsl")
		);
		cloudShader.setUniformTexture("cloud", Webpack.require("../../original/ch5/Assets/cloud.png"), 2);
		sunShader = new Material(ctx);
		sunShader.load(
			Webpack.require("./shaders/sun.vert.glsl"),
			Webpack.require("./shaders/sun.frag.glsl")
		);
		sunShader.setUniformTexture("sun", Webpack.require("../../original/ch5/Assets/sun.png"), 3);
		charMesh = new Mesh3D(ctx, charShader.program);
		buildMesh(charMesh, 0.05, 0.1, new Vec3(0, -0.345, 0));
		charMesh.build();
		bgMesh = new Mesh3D(ctx, bgShader.program);
		buildMesh(bgMesh, 1, 1, new Vec3(0, 0, 0.5));
		bgMesh.build();
		cloudMesh = new Mesh3D(ctx, cloudShader.program);
		buildMesh(cloudMesh, 0.2, 0.1, new Vec3(0, 0, 0));
		cloudMesh.build();
		sunMesh = new Mesh3D(ctx, sunShader.program);
		buildMesh(sunMesh, 1, 1, new Vec3(0, 0, 0.4));
		sunMesh.build();
	}
	override public function draw(delta:Float):Void {
		if (walkRight) {
			charPos += new Vec3(0.0004 * delta, 0, 0);
			frame = (frame > 10) ? 0.0 : frame += 0.2;
		} else {
			frame = 0.0;
		}
		super.draw(delta);
		enableDepthTest();
		setBlendingMode(RenderingContext.SRC_ALPHA, RenderingContext.ONE_MINUS_SRC_ALPHA);
		charShader.begin();
		charShader.setUniform3f("positionOffset", charPos);
		charShader.setUniform2f("size", new Vec2(0.28, 0.19));
		charShader.setUniform2f("frame", new Vec2(Std.int(frame % 3), Std.int(frame / 3)));
		charMesh.draw();
		charShader.end();
		bgShader.begin();
		bgMesh.draw();
		bgShader.end();
		setBlendingMode(RenderingContext.ONE, RenderingContext.ONE);
		sunShader.begin();
		sunMesh.draw();
		sunShader.end();
		setBlendingMode(RenderingContext.SRC_ALPHA, RenderingContext.ONE_MINUS_SRC_ALPHA);
		disableDepthTest();
		cloudShader.begin();
		cloudShader.setUniformMatrix4f("transform", buildMatrix(new Vec3(-0.55, 0, 0), 0, new Vec3(1, 1, 1)));
		cloudMesh.draw();
		cloudShader.end();
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
	private function onPress(e: KeyboardEvent) {
		if (e.code == "ArrowRight") {
			walkRight = true;
		}
	}
	private function onRelease(e: KeyboardEvent) {
		if (e.code == "ArrowRight") {
			walkRight = false;
		}
	}
	private function buildMatrix(trans: Vec3, rot: Float, scaling: Vec3): Mat4 {
		return translate(trans) * rotate(rot, new Vec3(0, 0, 1)) * scale(scaling);
	}
}
