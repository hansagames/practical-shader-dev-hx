package ch09;

import externs.Ogl.Program;
import externs.Ogl.Vec3;
import utils.DirectionalLight;

class BlinnPhongTorus extends LightModelBase {
	public function new() {
		super();
        }
        override private function createShader(): Program {
                return new Program(gl, {
                        vertex: Webpack.require("./shaders/blinnPhong.vert.glsl"),
                        fragment: Webpack.require("./shaders/blinnPhong.frag.glsl"),
                        uniforms: {
                                lightCol: {value: getLightColor(light)},
                                lightDir: {value: getLightDirection(light)},
                                meshCol: {value: new Vec3(0.0, 0.5, 1)},
                                meshSpecCol: {value: new Vec3(1, 1, 1)},
                                ambientCol: {value: new Vec3(0.0, 0.3, 0.0)},
                        },
                });
        }
}
