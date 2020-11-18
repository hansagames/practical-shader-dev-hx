package utils;

import VectorMath.Vec3;
import VectorMath.Mat4;

function translate(v: Vec3): Mat4 {
    return new Mat4(
        1, 0, 0, v.x,
        0, 1, 0, v.y,
        0, 0, 1, v.z,
        0, 0, 0, 1
    );
}

function scale(v: Vec3): Mat4 {
    return new Mat4(
        v.x, 0, 0, 0,
        0, v.y, 0, 0,
        0, 0, v.z, 0,
        0, 0, 0, 1
    );
}

function rotate(radians: Float, axis: Vec3): Mat4 {
    var m = new Mat4(
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
    );
    if (axis.x > 0) {
        m = m * rotateX(radians);
    }
    if (axis.y > 0) {
        m = m * rotateY(radians);
    } 
    if (axis.z > 0) {
        m = m * rotateZ(radians);
    }
    return m;
}

private function rotateX(radians: Float): Mat4 {
    return new Mat4(
        1, 0, 0, 0,
        0, Math.cos(radians), -Math.sin(radians), 0,
        0, Math.sin(radians), Math.cos(radians), 0,
        0, 0, 0, 1
    );
}
private function rotateY(radians: Float): Mat4 {
    return new Mat4(
        Math.cos(radians), 0, Math.sin(radians), 0,
        0, 1, 0, 0,
        -Math.sin(radians), 0, Math.cos(radians), 0,
        0, 0, 0, 1
    );
}
private function rotateZ(radians: Float): Mat4 {
    return new Mat4(
        Math.cos(radians), -Math.sin(radians), 0, 0,
        Math.sin(radians), Math.cos(radians), 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
    );
}