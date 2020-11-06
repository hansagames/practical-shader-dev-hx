package utils;

import VectorMath.Vec2;
import VectorMath.Vec4;
import VectorMath.Vec3;
import js.html.webgl.Program;
import js.html.webgl.Buffer;
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
	private var vertexPositionBuffer:Buffer;
	private var vertexColorBuffer:Buffer;
	private var indiciesBuffer: Buffer;
	private var uvBuffer: Buffer;
	private var shader:Program;

	public function new(ctx:RenderingContext, shader:Program) {
		this.ctx = ctx;
		this.shader = shader;
		vertexPositionBuffer = ctx.createBuffer();
		vertexColorBuffer = ctx.createBuffer();
		indiciesBuffer = ctx.createBuffer();
		uvBuffer = ctx.createBuffer();
		vertices = [];
		colors = [];
		indicies = [];
		uv = [];
		
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

		final uvAttriuteLocation = ctx.getAttribLocation(shader, "uv");
		if (uvAttriuteLocation >= 0) {
			ctx.enableVertexAttribArray(uvAttriuteLocation);
			ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, uvBuffer);
			ctx.vertexAttribPointer(uvAttriuteLocation, 2, RenderingContext.FLOAT, false, 0, 0);
		}
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
		this.indicies = indicies;
	}
	public function addTexCoord(c: Vec2): Void {
		uv.push(c.x);
		uv.push(c.y);
	}
	public function build():Void {
		if (indicies.length > 0) {
			ctx.bindBuffer(RenderingContext.ELEMENT_ARRAY_BUFFER, indiciesBuffer);
			ctx.bufferData(RenderingContext.ELEMENT_ARRAY_BUFFER, new Uint16Array(indicies), RenderingContext.STATIC_DRAW);
		}
		ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, vertexPositionBuffer);
		ctx.bufferData(RenderingContext.ARRAY_BUFFER, new Float32Array(vertices), RenderingContext.STATIC_DRAW);
		if (colors.length > 0) {
			ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, vertexColorBuffer);
			ctx.bufferData(RenderingContext.ARRAY_BUFFER, new Float32Array(colors), RenderingContext.STATIC_DRAW);
		}
		if (uv.length > 0) {
			ctx.bindBuffer(RenderingContext.ARRAY_BUFFER, uvBuffer);
			ctx.bufferData(RenderingContext.ARRAY_BUFFER, new Float32Array(uv), RenderingContext.STATIC_DRAW);
		}
	}

	public function draw():Void {
		if (this.indicies.length > 0) {
			ctx.drawElements(RenderingContext.TRIANGLES, indicies.length, RenderingContext.UNSIGNED_SHORT, 0);
		} else {
			ctx.drawArrays(RenderingContext.TRIANGLES, 0, Std.int(vertices.length / 3));
		}
	}
}
