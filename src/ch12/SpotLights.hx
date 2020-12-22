package ch12;

import utils.Degree.toRadians;
import utils.LoadTexture.loadTexture;
import ch12.LightBase;
import ch12.lights.SpotLight;
import externs.Ogl.Mesh;
import externs.Ogl.Program;
import externs.Ogl.Vec3;

class SpotLights extends LightBase {
	private var mesh: Null<Mesh> = null;
    private var light: SpotLight;
	public function new() {
		super();
		camera.position.set(0, 0, 6);
    }
    
    override private function setup():Void {
        super.setup();
        light = new SpotLight();
		light.intensity = 1.0;
        light.color = new Vec3(1, 1, 1);
        light.direction = new Vec3(0, 0, -1);
        light.position.set(0.5,0, 6);
        light.cutoff = Math.cos(toRadians(4.5));
        
        loadModel(
            Webpack.require("../../original/ch12/2_SpotLights/bin/shield.ply"),
            new Program(gl, {
                vertex: Webpack.require("./shaders/light.vert.glsl"),
                fragment: Webpack.require("./shaders/spotLight.frag.glsl"),
                uniforms: {
                    lightCol: { value: getLightColor(light) },
                    lightCutoff: { value: light.cutoff },
                    lightPos: { value: light.position },
                    lightConeDir: { value: light.direction },
				    diffuseTex: { value: loadTexture(Webpack.require("../../original/ch12/Assets/shield_diffuse.png"), gl) },
				    specTex: { value: loadTexture(Webpack.require("../../original/ch12/Assets/shield_spec.png"), gl)},
				    normalTex: { value: loadTexture(Webpack.require("../../original/ch12/Assets/shield_normal.png"), gl)} ,
                    cubeTexture: {value: createCubeMapTexture(gl, [
                        Webpack.require('../../original/ch12/Assets/night_left.jpg'),
                        Webpack.require('../../original/ch12/Assets/night_right.jpg'),
                        Webpack.require('../../original/ch12/Assets/night_top.jpg'),
                        Webpack.require('../../original/ch12/Assets/night_bottom.jpg'),
                        Webpack.require('../../original/ch12/Assets/night_back.jpg'),
                        Webpack.require('../../original/ch12/Assets/night_front.jpg'),
                    ])},
                },
            }),
            mesh -> {
                this.mesh = mesh;
            }
        );
    }
}
