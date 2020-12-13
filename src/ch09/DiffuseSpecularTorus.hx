package ch09;

import externs.Ogl.Program;
import externs.Ogl.Vec3;
import utils.DirectionalLight;

class DiffuseSpecularTorus extends LightModelBase {
	public function new() {
		super();
        }
        override private function createShader(): Program {
                return new Program(gl, {
                        vertex: Webpack.require("./shaders/diffuseSpecular.vert.glsl"),
                        fragment: Webpack.require("./shaders/diffuseSpecular.frag.glsl"),
                        uniforms: {
                                lightCol: {value: getLightColor(light)},
                                lightDir: {value: getLightDirection(light)},
                                meshCol: {value: new Vec3(1, 0, 1)},
                                meshSpecCol: {value: new Vec3(1, 1, 1)},
                        },
                });
        }
}
