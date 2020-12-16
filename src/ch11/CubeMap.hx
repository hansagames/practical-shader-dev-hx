package ch11;

import externs.Ogl.Program;
import externs.Ogl.Mesh;
import ch11.CubeMapBase;

class CubeMap extends CubeMapBase {
    private var mesh: Null<Mesh> = null;
    public function new() {
        super();
    }
    override private function setup():Void {
        super.setup();
        loadModel(
            Webpack.require("../../original/ch11/1_DrawCube/bin/data/cube.ply"),
            new Program(gl, {
                vertex: Webpack.require("./shaders/cubeMap.vert.glsl"),
                fragment: Webpack.require("./shaders/cubeMap.frag.glsl"),
                uniforms: {
                    cubeTexture: {value: createCubeMapTexture(gl, [
                        Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_left.jpg'),
                        Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_right.jpg'),
                        Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_top.jpg'),
                        Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_bottom.jpg'),
                        Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_back.jpg'),
                        Webpack.require('../../original/ch11/1_DrawCube/bin/data/cube_front.jpg'),
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
        if (mesh != null) {
            mesh.rotation.y += 0.01;
        }
	}
}
