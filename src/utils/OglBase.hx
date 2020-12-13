package utils;

import js.html.webgl.PowerPreference;
import externs.Ogl.Renderer;
import externs.Ogl.Camera;
import externs.Ogl.GL;
import externs.Ogl.Transform;
import externs.Ogl.Vec3;
import js.Browser;

class OglBase {
    private var renderer: Renderer;
    private var gl: GL;
    private var camera: Camera;
    private var scene: Transform;
	public function new() {
        createEngine();
		setup();
    }
    private function createEngine(): Void {
        renderer = new Renderer({ 
            dpr: 2, 
            antialias: true,
            powerPreference: PowerPreference.HIGH_PERFORMANCE 
        });
        gl = renderer.gl;
        Browser.document.body.appendChild(gl.canvas);

        gl.clearColor(1, 1, 1, 1);

        camera = new Camera(gl, { fov: 35 });
        camera.position.set(0, 0, 15);
        camera.lookAt(new Vec3(0, 0, 0));

        Browser.window.addEventListener("resize", resize, false);

        scene = new Transform();
        
        resize();
    }
    private function resize(): Void {
        renderer.setSize(Browser.window.innerWidth, Browser.window.innerHeight);
        camera.perspective({ aspect: gl.canvas.width / gl.canvas.height });
    }
    private function onFrame(dt: Float): Void {
        renderer.render({ scene: scene , camera: camera });
        Browser.window.requestAnimationFrame(onFrame);
    }
	private function setup():Void {
	}
}
