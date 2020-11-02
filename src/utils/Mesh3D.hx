package utils;

import gl_matrix.Vec4;
import js.html.webgl.Program;
import js.html.webgl.Buffer;
import js.lib.Float32Array;
import js.html.webgl.RenderingContext;
import types.Types.Mesh;
import gl_matrix.Vec3;

class Mesh3D implements Mesh {
	private var ctx:RenderingContext;
	private var vertices:Array<Float>;
	private var colors:Array<Float>;
	private var vertexPositionBuffer:Buffer;
	private var vertexColorBuffer:Buffer;
	private var shader:Program;

	public function new(ctx:RenderingContext, shader:Program) {
		this.ctx = ctx;
		this.shader = shader;
		vertexPositionBuffer = ctx.createBuffer();
		vertexColorBuffer = ctx.createBuffer();
		vertices = [];
		colors = [];
		
		final positionAttriuteLocation = ctx.getAttribLocation(shader, "position");
		ctx.enableVertexAttribArray(positionAttriuteLocation);
		ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, vertexPositionBuffer);
		ctx.vertexAttribPointer(positionAttriuteLocation, 3, RenderingContext.FLOAT, false, 0, 0);

		final colorAttriuteLocation = ctx.getAttribLocation(shader, "color");
		if (colorAttriuteLocation >= 0) {
			ctx.enableVertexAttribArray(colorAttriuteLocation);
			ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, vertexColorBuffer);
			ctx.vertexAttribPointer(colorAttriuteLocation, 4, RenderingContext.FLOAT, false, 0, 0);
		}
	};

	public function addVertex(vertex:Vec3):Void {
		vertices.push(untyped vertex[0]);
		vertices.push(untyped vertex[1]);
		vertices.push(untyped vertex[2]);
	}
	public function setVertex(index: Int, v:Vec3):Void {
		vertices[index] = untyped v[0];
		vertices[index + 1] = untyped v[1];
		vertices[index + 2] = untyped v[2];
	}
	public function getVertex(index: Int):Vec3 {
		return Vec3.set(
			Vec3.create(),
			vertices[index],
			vertices[index + 1],
			vertices[index + 2]
		);
	}
	public function addColor(color: Vec4): Void {
		colors.push(untyped color[0]);
		colors.push(untyped color[1]);
		colors.push(untyped color[2]);
		colors.push(untyped color[3]);
	}
	public function build():Void {
		ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, vertexPositionBuffer);
		ctx.bufferData(RenderingContext.ARRAY_BUFFER, new Float32Array(vertices), RenderingContext.STATIC_DRAW);
		if (colors.length > 0) {
			ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, vertexColorBuffer);
			ctx.bufferData(RenderingContext.ARRAY_BUFFER, new Float32Array(colors), RenderingContext.STATIC_DRAW);
		}
	}

	public function draw():Void {
		ctx.drawArrays(RenderingContext.TRIANGLES, 0, Std.int(vertices.length / 3));
	}
}
