package ch07;

import externs.Ogl.Program;
import externs.Ogl.Mesh;
import externs.Ogl.Geometry;
import utils.OglBase;
import externs.Ply.Loader;
import externs.Ply.PLYLoader;
import js.Browser;

class PerspectiveTorus extends OglBase {
    private var program: Program;
    private var mesh: Mesh;
	public function new() {
        super();
	}

	override private function setup():Void {
        super.setup();
        Loader.load(
            Webpack.require("../../assets/torus.ply"),
            PLYLoader,
            {}
        ).then(r -> {
            program = new Program(gl, {
                vertex: Webpack.require("./shaders/passthrough.vert.glsl"),
                fragment: Webpack.require("./shaders/uv_vis.frag.glsl"),
            });
            final geometry = new Geometry(gl, {
                position: { size: r.attributes.POSITION.size, data: r.attributes.POSITION.value },
                uv: { size: r.attributes.TEXCOORD_0.size, data: r.attributes.TEXCOORD_0.value },
                normal: { size: r.attributes.NORMAL.size, data: r.attributes.NORMAL.value },
                index: { size: r.indices.size, data: r.indices.value },
            });

            mesh = new Mesh(gl, { geometry: geometry, program: program });

            mesh.setParent(scene);

            Browser.window.requestAnimationFrame(onFrame);
        });
    }
    override public function onFrame(dt: Float): Void {
        super.onFrame(dt);
    }
}
