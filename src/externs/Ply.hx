package externs;

import js.lib.Float32Array;
import js.lib.Uint32Array;
import js.lib.Promise;

@:jsRequire("@loaders.gl/ply", "PLYLoader")
extern class PLYLoader {

}

interface Attribute {
    var size: Int;
    var value: Float32Array;
}

interface Indicies {
    var size: Int;
    var value: Uint32Array;
}

interface Attributes {
    var NORMAL: Attribute;
    var POSITION: Attribute;
    var TEXCOORD_0: Attribute;
}

interface PlyModel {
    var attributes: Attributes;
    var indices: Indicies;
}

@:jsRequire("@loaders.gl/core")
extern class Loader {
    public static function load(urls: String, loader: Dynamic, options: Dynamic): Promise<PlyModel>;
}