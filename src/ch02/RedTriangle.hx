package ch02;

import js.Browser;
import js.html.KeyboardEvent;
import types.Types.IShader;
import gl_matrix.Vec3;
import utils.Mesh3D;
import utils.BaseOfApp;
import utils.Material;
import types.Types.Mesh;

final fragment = '#version 300 es
precision highp float;

out vec4 outColor;

void main()
{
	outColor = vec4(1.0,0.0,0.0,1.0);
}';
final vertex = '#version 300 es
precision highp float;

in vec3 position; 

void main()
{
   	gl_Position = vec4(position, 1.0); 
}';

class RedTriangle extends BaseOfApp {
	private var triangle:Mesh;
	private var shader:IShader;

	public function new() {
		super();
		Browser.window.addEventListener("keydown", this.onKeyPressed);
	}

	override private function setup():Void {
		super.setup();
		final width = 2;
		final height = 2;
		shader = new Material(ctx);
		shader.load(vertex, fragment);
		triangle = new Mesh3D(ctx, shader.program);
		triangle.addVertex(Vec3.fromValues(-width * 0.5, height * 0.5, 0));
		triangle.addVertex(Vec3.fromValues(height * 0.5, width * 0.5, 0));
		triangle.addVertex(Vec3.fromValues(width * 0.5, -height * 0.5, 0));
		triangle.build();
	}

	override public function draw(delta:Float):Void {
		super.draw(delta);
		shader.begin();
		triangle.draw();
		shader.end();
	}
	private function onKeyPressed(e: KeyboardEvent): Void {
		final curPos = triangle.getVertex(0);
		triangle.setVertex(0, Vec3.add(Vec3.create(), curPos, Vec3.set(Vec3.create(), 0, 1, 0) ));
		triangle.build();
	}
}
