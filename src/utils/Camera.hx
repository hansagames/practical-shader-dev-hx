package utils;

import VectorMath.Vec3;
import types.Types.Camera as ICamera;

class Camera implements ICamera {
    public var position: Vec3;
    public var rotation: Float;
    public function new(position: Vec3, rotation: Float) {
        this.position = position;
        this.rotation = rotation;
    }
}