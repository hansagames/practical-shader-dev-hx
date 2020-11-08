package utils;

import js.html.webgl.Buffer;
import VectorMath.log;
import VectorMath.Vec2;
import VectorMath.Vec4;
import VectorMath.Vec3;
import js.html.webgl.Program;
import js.lib.Float32Array;
import js.lib.Uint16Array;
import js.html.webgl.RenderingContext;
import types.Types.Mesh;

class Mesh3D implements Mesh {
	private var ctx:RenderingContext;
	private var vertices:Array<Float>;
	private var indicies:Array<Float>;
	private var uv:Array<Float>;
	private var colors:Array<Float>;
	private var shader:Program;
	private var indiciesBuffer: Null<Buffer>;
	private var vertexPositionBuffer: Null<Buffer>;
	private var vertexColorBuffer: Null<Buffer>;
	private var uvBuffer: Null<Buffer>;

	public function new(ctx:RenderingContext, shader:Program) {
		this.ctx = ctx;
		this.shader = shader;
		vertices = [];
		colors = [];
		indicies = [];
		uv = [];
	};

	public function addVertex(vertex: Vec3):Void {
		vertices.push(vertex.x);
		vertices.push(vertex.y);
		vertices.push(vertex.z);
	}
	public function setVertex(index: Int, v:Vec3):Void {
		vertices[index] = v.x;
		vertices[index + 1] = v.y;
		vertices[index + 2] = v.z;
	}
	public function getVertex(index: Int):Vec3 {
		return new Vec3(
			vertices[index],
			vertices[index + 1],
			vertices[index + 2]
		);
	}
	public function addColor(color: Vec4): Void {
		colors.push(color.x);
		colors.push(color.y);
		colors.push(color.z);
		colors.push(color.w);
	}
	public function addIndicies(indicies: Array<Float>): Void {
		this.indicies = this.indicies.concat(indicies);
	}
	public function addTexCoord(c: Vec2): Void {
		uv.push(c.x);
		uv.push(c.y);
	}
	public function build():Void {
		final positionAttriuteLocation = ctx.getAttribLocation(shader, "position");
		vertexPositionBuffer = ctx.createBuffer();
		ctx.enableVertexAttribArray(positionAttriuteLocation);
		ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, vertexPositionBuffer);
		ctx.vertexAttribPointer(positionAttriuteLocation, 3, RenderingContext.FLOAT, false, 0, 0);
		ctx.bufferData(RenderingContext.ARRAY_BUFFER, new Float32Array(vertices), RenderingContext.STATIC_DRAW);

		final colorAttriuteLocation = ctx.getAttribLocation(shader, "color");
		if (colorAttriuteLocation >= 0) {
			vertexColorBuffer = ctx.createBuffer();
			ctx.enableVertexAttribArray(colorAttriuteLocation);
			ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, vertexColorBuffer);
			ctx.vertexAttribPointer(colorAttriuteLocation, 4, RenderingContext.FLOAT, false, 0, 0);
			ctx.bufferData(RenderingContext.ARRAY_BUFFER, new Float32Array(colors), RenderingContext.STATIC_DRAW);
		}
		final uvAttriuteLocation = ctx.getAttribLocation(shader, "uv");
		if (uvAttriuteLocation >= 0) {
			uvBuffer = ctx.createBuffer();
			ctx.enableVertexAttribArray(uvAttriuteLocation);
			ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, uvBuffer);
			ctx.vertexAttribPointer(uvAttriuteLocation, 2, RenderingContext.FLOAT, false, 0, 0);
			ctx.bufferData(RenderingContext.ARRAY_BUFFER, new Float32Array(uv), RenderingContext.STATIC_DRAW);
		}
		if (indicies.length > 0) {
			indiciesBuffer = ctx.createBuffer();
			ctx.bindBuffer(RenderingContext.ELEMENT_ARRAY_BUFFER, indiciesBuffer);
			ctx.bufferData(RenderingContext.ELEMENT_ARRAY_BUFFER, new Uint16Array(indicies), RenderingContext.STATIC_DRAW);
		}
	}

	public function draw():Void {
		if (vertexPositionBuffer != null) {
			ctx.enableVertexAttribArray(ctx.getAttribLocation(shader, "position"));
			ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, vertexPositionBuffer);
			ctx.vertexAttribPointer(ctx.getAttribLocation(shader, "position"), 3, RenderingContext.FLOAT, false, 0, 0);
			ctx.bufferData(RenderingContext.ARRAY_BUFFER, new Float32Array(vertices), RenderingContext.STATIC_DRAW);
		}
		if (vertexColorBuffer != null) {
			ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, vertexColorBuffer);
			ctx.bufferData(RenderingContext.ARRAY_BUFFER, new Float32Array(colors), RenderingContext.STATIC_DRAW);
		}
		if (uvBuffer != null) {
			ctx.enableVertexAttribArray(ctx.getAttribLocation(shader, "uv"));
			ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, uvBuffer);
			ctx.vertexAttribPointer(ctx.getAttribLocation(shader, "uv"), 2, RenderingContext.FLOAT, false, 0, 0);
			ctx.bufferData(RenderingContext.ARRAY_BUFFER, new Float32Array(uv), RenderingContext.STATIC_DRAW);
		}
		if (indiciesBuffer != null) {
			ctx.bindBuffer(RenderingContext.ELEMENT_ARRAY_BUFFER, indiciesBuffer);
			ctx.bufferData(RenderingContext.ELEMENT_ARRAY_BUFFER, new Uint16Array(indicies), RenderingContext.STATIC_DRAW);
			ctx.drawElements(RenderingContext.TRIANGLES, indicies.length, RenderingContext.UNSIGNED_SHORT, 0);
		} else {
			ctx.drawArrays(RenderingContext.TRIANGLES, 0, Std.int(vertices.length / 3));
		} 
	}
}
