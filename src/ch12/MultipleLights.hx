package ch12;

import ch12.lights.PointLight;
import utils.DirectionalLight;
import utils.Degree.toRadians;
import utils.LoadTexture.loadTexture;
import ch12.LightBase;
import ch12.lights.SpotLight;
import externs.Ogl.Mesh;
import externs.Ogl.Program;
import externs.Ogl.Vec3;

class MultipleLights extends LightBase {
	private var mesh: Null<Mesh> = null;
	public function new() {
		super();
		camera.position.set(0, 0, 6);
    }
    
    override private function setup():Void {
        super.setup();
        final directionalLights: Array<DirectionalLight> = [];
        final pointLights: Array<PointLight> = [];
        final spotLights: Array<SpotLight> = [];
        directionalLights.push(new DirectionalLight(
            new Vec3(0, -1, 0),
            new Vec3(1, 1, 1),
            2
        ));
        pointLights.push(new PointLight(
            new Vec3(0, 0.5, 0.75),
            new Vec3(1, 0, 1),
            4,
            1
        ));
        pointLights.push(new PointLight(
            new Vec3(0.5, 0.5, 0.75),
            new Vec3(0, 1, 1),
            4,
            1
        ));
        spotLights.push(new SpotLight(
            new Vec3(0.5, 0 ,6),
            new Vec3(0, 0, -1),
            new Vec3(1, 0, 0),
            1.0,
            Math.cos(toRadians(4.5))
        ));
        spotLights.push(new SpotLight(
            new Vec3(-0.5, 0 ,6),
            new Vec3(0, 0, -1),
            new Vec3(0, 1, 0),
            1.0,
            Math.cos(toRadians(4.5))
        ));

        final program = new Program(gl, {
            vertex: Webpack.require("./shaders/light.vert.glsl"),
            fragment: Webpack.require("./shaders/multiplLights.frag.glsl"),
            uniforms: {
                "directionalLights": directionalLights,
                "spotLights": spotLights,
                "pointLights": pointLights,
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
        });
        
        loadModel(
            Webpack.require("../../original/ch12/Assets/shield.ply"),
            program,
            mesh -> {
                this.mesh = mesh;
            }
        );
    }
}
