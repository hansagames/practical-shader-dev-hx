package utils;

import js.html.KeyboardEvent;
import js.Browser;
import js.html.webgl.RenderingContext;
import types.Types.BaseApp;
import js.html.webgl.PowerPreference;

class BaseOfApp implements BaseApp {
	private var ctx:RenderingContext;
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
		});
		ctx.viewport(0, 0, canvas.width, canvas.height);
		Browser.document.body.appendChild(canvas);
		Browser.window.requestAnimationFrame(draw);
	}

	public function draw(delta:Float) {
		ctx.clearColor(0.2, 0.2, 0.2, 1.0);
		ctx.clear(RenderingContext.COLOR_BUFFER_BIT | RenderingContext.DEPTH_BUFFER_BIT);
		ctx.enable(RenderingContext.DEPTH_TEST);
		Browser.window.requestAnimationFrame(draw);
	}
}
