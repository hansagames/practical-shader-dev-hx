package externs;

import js.lib.Float32Array;
import js.lib.Uint32Array;
import js.html.webgl.RenderingContext;


typedef RendererOptions = {
    var ?dpr: Float;
};

@:jsRequire("ogl", "GL")
class GL extends RenderingContext {
    var renderer: Renderer;
}

typedef RenderProps = {
    var scene: Transform;
    var camera: Camera;
}

@:jsRequire("ogl", "Renderer")
extern class Renderer {
    public function new(options: RendererOptions): Void;
    public var gl: GL;
    public function setSize(width: Float, height: Float): Void;
    public function render(props: RenderProps): Void;

}
@:jsRequire("ogl", "Vec3")
extern class Vec3 {
    public function new(?x: Float, ?y: Float, ?z: Float): Void;
    var x: Float;
    var y: Float;
    var z: Float;
    public function set(x: Float, y: Float, z: Float): Void;
}
@:jsRequire("ogl", "Eulor")
extern class Euler {
    public function new(?x: Float, ?y: Float, ?z: Float): Void;
    var x: Float;
    var y: Float;
    var z: Float;
    public function set(x: Float, y: Float, z: Float): Void;
}
@:jsRequire("ogl", "Transform")
extern class Transform {
    var position: Vec3;
    var rotation: Euler;
    public function new(): Void;
    public function lookAt(target: Vec3, ?inverse: Bool): Void;
    public function setParent(node: Null<Transform>): Void;
}

typedef CreateCameraProps = {
    var ?fov: Int;
}
typedef CameraPerspectiveProps = {
    var aspect: Float;
}
@:jsRequire("ogl", "Camera")
extern class Camera extends Transform { 
    public function new(gl: GL, options: CreateCameraProps): Void;
    public function perspective(props: CameraPerspectiveProps): Void;
}

typedef CreateProgramProps = {
    var vertex: String;
    var fragment: String;
    var ?uniforms: Dynamic;
}
@:jsRequire("ogl", "Program")
extern class Program {
    public function new(gl: GL, options: CreateProgramProps): Void;
}

typedef GeometryData<T> = {
    var size: Int;
    var data: T;
};

typedef CreateGeometryProps = {
    var position: GeometryData<Float32Array>;
    var uv: GeometryData<Float32Array>;
    var normal: GeometryData<Float32Array>;
    var ?index: GeometryData<Uint32Array>;
}
@:jsRequire("ogl", "Geometry")
extern class Geometry {
    public function new(gl: GL, options: CreateGeometryProps): Void;
    public function setDrawRange(start: Int, count: Int): Void;
}

typedef CreateMeshProps = {
    var program: Program;
    var geometry: Geometry;
};
@:jsRequire("ogl", "Mesh")
extern class Mesh extends Transform {
    public function new(gl: GL, options: CreateMeshProps): Void;
}