package types;

import gl_matrix.Vec4;
import js.html.webgl.Program;
import gl_matrix.Vec3;

interface BaseApp {
	// public function update():Void;
	public function draw(delta:Float):Void;
}

interface Mesh {
	public function build():Void;
	public function draw():Void;
	public function addVertex(vertex:Vec3):Void;
	public function getVertex(index: Int): Vec3;
	public function setVertex(index: Int, v: Vec3): Void;
	public function addColor(color: Vec4): Void;
}

interface IShader {
	public var program:Program;
	public function load(vert:String, frag:String):Void;
	public function begin():Void;
	public function end():Void;
	public function setUniform4f(name: String, v: Vec4): Void;
}
