package ch10;

import utils.LoadTexture.loadTexture;
import js.html.webgl.WebGL2RenderingContext;
import externs.Ogl.Program;
import externs.Ogl.Vec3;
import utils.DirectionalLight;

class Water extends NormalMappingBase {
	public function new() {
		super();
		light.direction = new Vec3(0.5, -1, -1);
    }
    override private function createShader():Program {
		return new Program(gl, {
			vertex: Webpack.require("./shaders/water.vert.glsl"),
			fragment: Webpack.require("./shaders/water.frag.glsl"),
			uniforms: {
				time: { value: 0 },
				lightCol: {value: getLightColor(light)},
				lightDir: {value: getLightDirection(light)},
				normalTex: {value: loadTexture(
					Webpack.require("../../original/ch10/Assets/water_nrm.png"),
					gl,
					{
						wrapS: WebGL2RenderingContext.REPEAT,
						wrapT: WebGL2RenderingContext.REPEAT,
						flipY: false,
					}
				)},
			},
			cullFace: null,
		});
	}

	override private function getModel() {
		return Webpack.require("../../original/ch10/Assets/plane.ply");
	}
	override public function onFrame(dt:Float):Void {
		super.onFrame(dt);
		program.uniforms.time.value = dt * 0.001;
		mesh.rotation.x = Math.PI * 1.3;
		mesh.rotation.y = Math.PI;
	}
}
