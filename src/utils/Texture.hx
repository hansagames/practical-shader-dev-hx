package utils;

import js.lib.Uint8Array;
import js.Browser;
import js.html.webgl.RenderingContext;

class Texture {
    public function new(src: String, ctx: RenderingContext, index: Int) {
        trace(src);
        final texture = ctx.createTexture();
        ctx.bindTexture(RenderingContext.TEXTURE_2D, texture);
        ctx.texImage2D(RenderingContext.TEXTURE_2D, index, RenderingContext.RGBA, 1, 1, 0, RenderingContext.RGBA, RenderingContext.UNSIGNED_BYTE,
            new Uint8Array([0, 0, 0, 255]));
        final img = Browser.document.createImageElement();
        img.src = src;
        img.addEventListener("load", () -> {
            ctx.bindTexture(RenderingContext.TEXTURE_2D, texture);
            ctx.texImage2D(RenderingContext.TEXTURE_2D, index, RenderingContext.RGBA, RenderingContext.RGBA, RenderingContext.UNSIGNED_BYTE, img);
            ctx.generateMipmap(RenderingContext.TEXTURE_2D);
        });
    }
}