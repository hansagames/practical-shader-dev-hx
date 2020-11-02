package ch02;

import gl_matrix.Vec4;
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
in vec4 fragColor;

void main()
{
	outColor = fragColor;
}';
final vertex = '#version 300 es
precision highp float;

layout (location = 0) in vec3 position; 
layout (location = 1) in vec4 color; 

out vec4 fragColor;

void main()
{
	fragColor = color;
   	gl_Position = vec4(position, 1.0); 
}';

class ColorTriangle extends BaseOfApp {
	private var triangle:Mesh;
	private var shader:IShader;

	public function new() {
		super();
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

		triangle.addColor(Vec4.fromValues(1, 0, 0, 1));
		triangle.addColor(Vec4.fromValues(0, 1, 0, 1));
		triangle.addColor(Vec4.fromValues(0, 0, 1, 1));
		triangle.build();
	}

	override public function draw(delta:Float):Void {
		super.draw(delta);
		shader.begin();
		triangle.draw();
		shader.end();
	}
}
