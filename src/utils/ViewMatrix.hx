package utils;

import VectorMath.Vec3;
import utils.BuildMatrix.buildMatrix;
import utils.Matrix.inverse;
import types.Types.Camera;
import VectorMath.Mat4;

function buildViewMatrix(camera: Camera): Mat4 {
    return inverse(buildMatrix(camera.position, camera.rotation, new Vec3(1, 1, 1)));
}