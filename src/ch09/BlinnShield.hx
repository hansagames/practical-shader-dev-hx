package ch09;

import js.html.Image;
import externs.Ogl.Texture;
import externs.Ogl.Program;
import externs.Ogl.Vec3;
import utils.DirectionalLight;

class BlinnShield extends LightModelBase {
	public function new() {
                super();
                camera.position.set(0, 0, 3);
        }
        override private function createShader(): Program {
                return new Program(gl, {
                        vertex: Webpack.require("./shaders/blinnShield.vert.glsl"),
                        fragment: Webpack.require("./shaders/blinnShield.frag.glsl"),
                        uniforms: {
                                lightCol: { value: getLightColor(light) },
                                lightDir: { value: getLightDirection(light) },
                                ambientCol: { value: new Vec3(0.0, 0.0, 0.0) },
                                diffuseTex: { value: loadTexture(Webpack.require("../../original/ch9/Assets/shield_diffuse.png")) },
                                specTex: { value: loadTexture(Webpack.require("../../original/ch9/Assets/shield_spec.png")) },
                        },
                });
        }
        override function getModel() {
                return Webpack.require("../../original/ch9/Assets/shield.ply");
        }
        private function loadTexture(path: String): Texture {
                final texture = new Texture(gl);
                final img = new Image();
                img.src = path;
                img.onload = () -> texture.image = img;
                return texture;
        }
        override function rotateMesh(dt:Float) {
                mesh.rotation.x = -Math.PI * 0.25;
                mesh.rotation.y += 0.01;
        }
}
