package ch10;

import utils.LoadTexture.loadTexture;
import externs.Ogl.Program;
import externs.Ogl.Vec3;
import utils.DirectionalLight;

class NormalMapping extends NormalMappingBase {
	public function new() {
		super();
    }
    override private function createShader():Program {
		return new Program(gl, {
			vertex: Webpack.require("./shaders/normalMapping.vert.glsl"),
			fragment: Webpack.require("./shaders/normalMapping.frag.glsl"),
			uniforms: {
				lightCol: {value: getLightColor(light)},
				lightDir: {value: getLightDirection(light)},
				ambientCol: {value: new Vec3(0.0, 0.0, 0.0)},
				diffuseTex: {value: loadTexture(Webpack.require("../../original/ch10/Assets/shield_diffuse.png"), gl)},
				specTex: {value: loadTexture(Webpack.require("../../original/ch10/Assets/shield_spec.png"), gl)},
				normalTex: {value: loadTexture(Webpack.require("../../original/ch10/Assets/shield_normal.png"), gl)},
			},
		});
	}

	override private function getModel() {
		return Webpack.require("../../original/ch10/Assets/shield.ply");
	}

	override public function onFrame(dt:Float):Void {
		super.onFrame(dt);
		rotateMesh(dt);
	}

	function rotateMesh(dt:Float) {
		mesh.rotation.x = -Math.PI * 0.25;
		mesh.rotation.y += 0.01;
	}
}
