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
uniform vec4 fragColor;

void main()
{
	outColor = fragColor;
}';
final vertex = '#version 300 es
precision highp float;

layout (location = 0) in vec3 position; 

void main()
{
   	gl_Position = vec4(position, 1.0); 
}';

class FirstUniform extends BaseOfApp {
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
		triangle.build();
	}

	override public function draw(delta:Float):Void {
		super.draw(delta);
		shader.begin();
		shader.setUniform4f("fragColor", Vec4.fromValues(1,0,1,1));
		triangle.draw();
		shader.end();
	}
}
