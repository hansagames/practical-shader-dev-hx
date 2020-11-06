package utils;

import js.html.webgl.UniformLocation;
import VectorMath.Vec4;
import types.Types.IShader;
import js.html.webgl.Program;
import js.html.webgl.RenderingContext;
import js.html.webgl.Shader;

class Material implements IShader {
	private var ctx:RenderingContext;
	private var textures: Array<UniformLocation> = [];

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
		ctx.pixelStorei(RenderingContext.UNPACK_FLIP_Y_WEBGL, 1);
		ctx.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_S, RenderingContext.REPEAT);
		ctx.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_T, RenderingContext.REPEAT);
		for (i in 0...textures.length) {
			ctx.uniform1i(textures[i], i);
		}
	}

	public function end() {}

	public function setUniform4f(name: String, v: Vec4): Void {
		final location = ctx.getUniformLocation(program, name);
		ctx.uniform4f(location, v.x, v.y, v.z, v.w);
	}
	public function setUniform1f(name: String, f: Float): Void {
		final location = ctx.getUniformLocation(program, name);
		if (location != null) {
			ctx.uniform1f(location, f);
		}
	}
	public function setUniformTexture(name: String, src: String): Void {
		new Texture(src, ctx, textures.length);
		final textureLocation = ctx.getUniformLocation(program, name);
		if (textureLocation != null) {
			textures.push(textureLocation);
		}
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
