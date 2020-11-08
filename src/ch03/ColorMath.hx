package ch03;

import VectorMath.log;
import VectorMath.Vec2;
import VectorMath.Vec4;
import VectorMath.Vec3;
import types.Types.IShader;
import utils.Mesh3D;
import utils.BaseOfApp;
import utils.Material;
import types.Types.Mesh;


class ColorMath extends BaseOfApp {
	private var quad:Mesh;
	private var shader:IShader;
	public function new() {
		super();
	}

	override private function setup():Void {
		super.setup();
		shader = new Material(ctx);
		shader.load(
			Webpack.require("./shaders/color-math.vert.glsl"),
			Webpack.require("./shaders/color-math.frag.glsl")
		);
		shader.setUniformTexture("parrotTex", Webpack.require("../../assets/parrot.png"), 0);
		quad = new Mesh3D(ctx, shader.program);
		quad.addVertex(new Vec3(-1, -1, 0));
		quad.addVertex(new Vec3(-1, 1, 0));
		quad.addVertex(new Vec3(1, 1, 0));
		quad.addVertex(new Vec3(1, -1, 0));

		quad.addColor(new Vec4(1, 0, 0, 1));
		quad.addColor(new Vec4(0, 1, 0, 1));
		quad.addColor(new Vec4(0, 0, 1, 1));
		quad.addColor(new Vec4(1, 1, 1, 1));

		quad.addTexCoord(new Vec2(0, 0));
		quad.addTexCoord(new Vec2(0, 1));
		quad.addTexCoord(new Vec2(1, 1));
		quad.addTexCoord(new Vec2(1, 0));

		quad.addIndicies([0, 1, 2, 2, 3, 0]);
		quad.build();
	}

	override public function draw(delta:Float):Void {
		super.draw(delta);
		shader.begin();
		shader.setUniform4f("multiplay", new Vec4(0.5, 0.5, 0.1, 1.0));
		shader.setUniform4f("add", new Vec4(0.1, 0.1, 0.1, 0.0));
		quad.draw();
		shader.end();
	}
}
