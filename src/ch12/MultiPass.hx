package ch12;

import ch12.multipass.PointLight;
import ch12.multipass.DirectionalLight;
import utils.LoadTexture.loadTexture;
import ch12.LightBase;
import externs.Ogl.Mesh;
import externs.Ogl.Program;
import externs.Ogl.Vec3;

class MultiPass extends LightBase {
    private var mesh: Null<Mesh> = null;
    private var directionalLightShader: Null<Program> = null;
    private var pointLightShader: Null<Program> = null;
    private var shieldShader: Null<Program> = null;
    private var directionalLight: Null<DirectionalLight> = null;
    private var pointLights: Null<Array<PointLight>> = null;
	public function new() {
		super();
		camera.position.set(0, 0, 6);
    }
    
    override private function setup():Void {
        super.setup();
        pointLights = [];
        directionalLight = new DirectionalLight(
            new Vec3(0, -1, 0),
            new Vec3(1, 1, 1),
            2
        );
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

        directionalLightShader = new Program(gl, {
            vertex: Webpack.require("./shaders/light.vert.glsl"),
            fragment: Webpack.require("./shaders/pointLight.frag.glsl"),
            uniforms: {},
        });

        pointLightShader = new Program(gl, {
            vertex: Webpack.require("./shaders/light.vert.glsl"),
            fragment: Webpack.require("./shaders/pointLight.frag.glsl"),
            uniforms: {},
        });

        shieldShader = new Program(gl, {
            vertex: Webpack.require("./shaders/light.vert.glsl"),
            fragment: Webpack.require("./shaders/multiplLights.frag.glsl"),
            uniforms: {
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
            shieldShader,
            mesh -> {
                this.mesh = mesh;
            }
        );
    }
}
