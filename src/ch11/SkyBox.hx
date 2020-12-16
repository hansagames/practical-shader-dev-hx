package ch11;

import externs.Ogl.Vec3;
import utils.LoadTexture.loadTexture;
import utils.DirectionalLight.getLightDirection;
import utils.DirectionalLight.getLightColor;
import js.html.webgl.WebGL2RenderingContext;
import externs.Ogl.Program;
import externs.Ogl.Mesh;
import ch11.CubeMapBase;

class SkyBox extends CubeMapBase {
    private var water: Null<Mesh>;
    public function new() {
        super();
    }
    override private function setup():Void {
        super.setup();
        light.direction = new Vec3(0.5, -1, -1);
        final cubeTexture = createCubeMapTexture(gl, [
            Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_left.jpg'),
            Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_right.jpg'),
            Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_top.jpg'),
            Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_bottom.jpg'),
            Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_back.jpg'),
            Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_front.jpg'),
        ]);
        loadModel(
            Webpack.require("../../original/ch11/1_DrawCube/bin/data/cube.ply"),
            new Program(gl, {
                vertex: Webpack.require("./shaders/skyBox.vert.glsl"),
                fragment: Webpack.require("./shaders/cubeMap.frag.glsl"),
                uniforms: {
                    cubeTexture: {value: cubeTexture},
                },
                depthFunc: WebGL2RenderingContext.LEQUAL,
                frontFace: WebGL2RenderingContext.CW,
            }),
            mesh -> {
                mesh.scale.set(4,4,4);
            }
        );
        loadModel(
            Webpack.require("../../original/ch11/Assets/plane.ply"),
            new Program(gl, {
                vertex: Webpack.require("./shaders/water.vert.glsl"),
                fragment: Webpack.require("./shaders/water.frag.glsl"),
                uniforms: {
                    cubeTexture: {value: cubeTexture},
                    time: { value: 0 },
                    lightCol: {value: getLightColor(light)},
                    lightDir: {value: getLightDirection(light)},
                    normalTex: {value: loadTexture(
                        Webpack.require("../../original/ch10/Assets/water_nrm.png"),
                        gl,
                        {
                            wrapS: WebGL2RenderingContext.REPEAT,
                            wrapT: WebGL2RenderingContext.REPEAT,
                        }
                    )},
                },
            }),
            mesh -> {
                mesh.scale.set(10,10,1);
                mesh.rotation.x = Math.PI * 1.45;
                mesh.rotation.y = Math.PI;
                mesh.position.y -= 4;
                mesh.position.z -= 8;
                water = mesh;
            }
        );
    }
    override public function onFrame(dt:Float):Void {
        super.onFrame(dt);
        if (water != null) {
            water.program.uniforms.time.value = dt * 0.001;
        }
	}
}
