package ch08;

import externs.Ogl.Vec3;
import utils.DirectionalLight;
import externs.Ogl.Program;
import externs.Ogl.Mesh;
import externs.Ogl.Geometry;
import utils.OglBase;
import externs.Ply.Loader;
import externs.Ply.PLYLoader;
import js.Browser;

class DiffuseLighting extends OglBase {
    private var program: Program;
    private var mesh: Mesh;
    private var light: DirectionalLight;
	public function new() {
        super();
        light = new DirectionalLight();
        light.intensity = 1.0;
        light.color = new Vec3(1, 1, 1);
        light.direction = new Vec3(0, -1, 0);
	}

	override private function setup():Void {
        super.setup();
        Loader.load(
            Webpack.require("../../assets/torus.ply"),
            PLYLoader,
            {}
        ).then(r -> {
            program = new Program(gl, {
                vertex: Webpack.require("./shaders/diffuse_light.vert.glsl"),
                fragment: Webpack.require("./shaders/diffuse_light.frag.glsl"),
                uniforms: {
                    lightCol: { value: getLightColor(light) },
                    lightDir: { value: getLightDirection(light) },
                    meshCol: { value: new Vec3(1, 0, 1) }
                },
            });
            final geometry = new Geometry(gl, {
                position: { size: r.attributes.POSITION.size, data: r.attributes.POSITION.value },
                uv: { size: r.attributes.TEXCOORD_0.size, data: r.attributes.TEXCOORD_0.value },
                normal: { size: r.attributes.NORMAL.size, data: r.attributes.NORMAL.value },
                index: { size: r.indices.size, data: r.indices.value },
            });

            mesh = new Mesh(gl, { geometry: geometry, program: program });
            mesh.rotation.x = Math.PI * 0.75;
            mesh.setParent(scene);

            Browser.window.requestAnimationFrame(onFrame);
        });
    }
    override public function onFrame(dt: Float): Void {
        super.onFrame(dt);
    }
}
