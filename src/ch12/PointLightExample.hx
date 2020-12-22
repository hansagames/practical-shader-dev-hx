package ch12;

import utils.LoadTexture.loadTexture;
import ch12.LightBase;
import ch12.lights.PointLight;
import externs.Ogl.Mesh;
import externs.Ogl.Program;
import externs.Ogl.Vec3;

class PointLightExample extends LightBase {
	private var mesh: Null<Mesh> = null;
    private var light: PointLight;
    private var time: Float = 0.0;
	public function new() {
		super();
		camera.position.set(0, 0, 6);
    }
    
    override private function setup():Void {
        super.setup();
        light = new PointLight();
		light.intensity = 3.0;
		light.radius = 1;
        light.color = new Vec3(1, 1, 1);
        light.position.set(0, 0.5, 0.75);
        
        loadModel(
            Webpack.require("../../original/ch12/1_PointLights/bin/shield.ply"),
            new Program(gl, {
                vertex: Webpack.require("./shaders/light.vert.glsl"),
                fragment: Webpack.require("./shaders/pointLight.frag.glsl"),
                uniforms: {
                    lightCol: { value: getLightColor(light) },
                    lightRadius: { value: light.radius },
                    lightPos: { value: light.position },
				    diffuseTex: { value: loadTexture(Webpack.require("../../original/ch12/Assets/shield_diffuse.png"), gl) },
				    specTex: { value: loadTexture(Webpack.require("../../original/ch12/Assets/shield_spec.png"), gl)},
				    normalTex: { value: loadTexture(Webpack.require("../../original/ch12/Assets/shield_normal.png"), gl)} ,
                    cubeTexture: {value: createCubeMapTexture(gl, [
                        Webpack.require('../../original/ch12/1_PointLights/bin/cube_left.jpg'),
                        Webpack.require('../../original/ch12/1_PointLights/bin/cube_right.jpg'),
                        Webpack.require('../../original/ch12/1_PointLights/bin/cube_top.jpg'),
                        Webpack.require('../../original/ch12/1_PointLights/bin/cube_bottom.jpg'),
                        Webpack.require('../../original/ch12/1_PointLights/bin/cube_back.jpg'),
                        Webpack.require('../../original/ch12/1_PointLights/bin/cube_front.jpg'),
                    ])},
                },
            }),
            mesh -> {
                this.mesh = mesh;
            }
        );
    }
    override public function onFrame(dt:Float):Void {
        super.onFrame(dt);
        if (light != null) {
            time += 0.01;
            light.position = new Vec3(Math.sin(time), 0.5, 0.75);
            if (mesh != null) {
                mesh.program.uniforms.lightPos.value = light.position;
                mesh.rotation.x += 0.01;
                mesh.rotation.y += 0.01;
                mesh.rotation.z += 0.01;
            }
        }
	}
}
