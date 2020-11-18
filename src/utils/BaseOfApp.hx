package utils;

import VectorMath.log;
import js.html.KeyboardEvent;
import js.Browser;
import js.html.webgl.RenderingContext;
import types.Types.BaseApp;
import js.html.webgl.PowerPreference;

class BaseOfApp implements BaseApp {
	private var ctx:RenderingContext;
	private var blendSource = RenderingContext.SRC_ALPHA;
	private var blendDestination = RenderingContext.ONE_MINUS_SRC_ALPHA;
	private var previousFrameTime: Float = -1;
	public function new() {
		setup();
	}

	private function setup():Void {
		final canvas = Browser.document.createCanvasElement();
		canvas.width = 1024;
		canvas.height = 768;
		canvas.id = "canvas";
		ctx = canvas.getContextWebGL2({
			powerPreference: PowerPreference.HIGH_PERFORMANCE,
			premultipliedAlpha: true,
			antialias: true,
			alpha: false
		});
		ctx.viewport(0, 0, canvas.width, canvas.height);
		Browser.document.body.appendChild(canvas);
		Browser.window.requestAnimationFrame(onFrame);
	}
	public function setBlendingMode(source: Int, destination: Int): Void {
		blendSource = source;
		blendDestination = destination;
		ctx.blendFunc(blendSource, blendDestination);
	}
	public function onFrame(time: Float) {
		var delta = 0.0;
		if (previousFrameTime == -1) {
			delta = 16;
		} else {
			delta = time - previousFrameTime;
		}
		previousFrameTime = time;
		draw(delta);
		Browser.window.requestAnimationFrame(onFrame);
	}
	public function draw(delta:Float) {
		ctx.viewport(0, 0, ctx.canvas.width, ctx.canvas.height);
		ctx.enable(RenderingContext.BLEND);
		ctx.enable(RenderingContext.DEPTH_TEST);
		ctx.blendFunc(blendSource, blendDestination);
		ctx.clearColor(0.2, 0.2, 0.2, 1.0);
		ctx.clear(RenderingContext.COLOR_BUFFER_BIT | RenderingContext.DEPTH_BUFFER_BIT);
		
	}
	public function enableDepthTest(): Void {
		ctx.enable(RenderingContext.DEPTH_TEST);
	}
	public function disableDepthTest(): Void {
		ctx.disable(RenderingContext.DEPTH_TEST);
	}
}
