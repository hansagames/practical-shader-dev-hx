package utils;

import utils.LoadImage.loadImage;
import externs.Ogl.GL;
import externs.Ogl.TextureProps;
import externs.Ogl.Texture;

function loadTexture(path:String, gl: GL, ?props: TextureProps):Texture {
    final texture = new Texture(gl, props);
    loadImage(path).then(img -> {
        texture.image = img;
    });
    return texture;
}