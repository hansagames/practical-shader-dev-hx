package utils;

import gl_matrix.Vec4;
import types.Types.IShader;
import js.html.webgl.Program;
import js.html.webgl.RenderingContext;
import js.html.webgl.Shader;

class Material implements IShader {
	private var ctx:RenderingContext;

	public var program:Program;

	public function new(ctx:RenderingContext) {
		this.ctx = ctx;
	}

	public function load(vert:String, frag:String) {
		program = createProgram(ctx, vert, frag);
		ctx.linkProgram(program);
	}

	public function begin() {
		ctx.useProgram(program);
	}

	public function end() {}

	public function setUniform4f(name: String, v: Vec4): Void {
		final location = ctx.getUniformLocation(program, name);
		ctx.uniform4f(location, untyped v[0], untyped v[1], untyped v[2], untyped v[3]);
	}
}

private function createProgram(ctx:RenderingContext, vert:String, frag:String):Program {
	final program = ctx.createProgram();
	ctx.attachShader(program, createShader(ctx, RenderingContext.VERTEX_SHADER, vert));
	ctx.attachShader(program, createShader(ctx, RenderingContext.FRAGMENT_SHADER, frag));
	return program;
}

private function createShader(ctx:RenderingContext, type:Int, source:String):Shader {
	final shader = ctx.createShader(type);
	ctx.shaderSource(shader, source);
	ctx.compileShader(shader);
	return shader;
}
