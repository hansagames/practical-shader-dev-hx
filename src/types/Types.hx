package types;

import VectorMath.Mat4;
import VectorMath.Vec2;
import VectorMath.Vec4;
import VectorMath.Vec3;
import js.html.webgl.Program;
import js.lib.Float32Array;

interface BaseApp {
	// public function update():Void;
	public function draw(delta:Float):Void;
	public function setBlendingMode(source: Int, destination: Int): Void;
	public function enableDepthTest(): Void;
	public function disableDepthTest(): Void;
}

interface Mesh {
	public function build():Void;
	public function draw():Void;
	public function addVertex(vertex: Vec3):Void;
	public function getVertex(index: Int): Vec3;
	public function setVertex(index: Int, v: Vec3): Void;
	public function addColor(color: Vec4): Void;
	public function addIndicies(indicies: Array<Float>): Void;
	public function addTexCoord(c: Vec2): Void;
}

interface IShader {
	public var program:Program;
	public function load(vert:String, frag:String):Void;
	public function begin():Void;
	public function end():Void;
	public function setUniform4f(name: String, v: Vec4): Void;
	public function setUniform3f(name: String, v: Vec3): Void;
	public function setUniform2f(name: String, v: Vec2): Void;
	public function setUniform1f(name: String, f: Float): Void;
	public function setUniformMatrix4f(name: String, m: Mat4): Void;
	public function setUniformTexture(name: String, src: String, slot: Int, ?flipY: Int): Void;
}

interface Camera {
	public var position: Vec3;
	public var rotation: Float;
}
