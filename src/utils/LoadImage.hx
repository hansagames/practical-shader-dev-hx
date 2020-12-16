package utils;

import js.html.Image;
import js.lib.Promise;

function loadImage(src: String): Promise<Image> {
    return new Promise<Image>((success, reject) -> {
        final img = new Image();
        img.onload = () -> success(img);
        img.src = src;
    });
}