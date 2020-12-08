package utils;

import utils.Transformation.scale;
import utils.Transformation.rotate;
import utils.Transformation.translate;
import VectorMath.Mat4;
import VectorMath.Vec3;

function buildMatrix(trans: Vec3, rot: Float, scaling: Vec3): Mat4 {
    return translate(trans) * rotate(rot, new Vec3(0, 0, 1)) * scale(scaling);
}