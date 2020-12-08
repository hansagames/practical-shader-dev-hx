package utils;

import externs.Ogl.Vec3;

class DirectionalLight {
    public var direction: Vec3;
    public var color: Vec3;
    public var intensity: Float;
    public function new() {
        direction = new Vec3();
        color = new Vec3(1, 1, 1);
        intensity = 1;
    }
}

function getLightDirection(light: DirectionalLight): Vec3 {
    return light.direction.clone().negate().normalize();
}
function getLightColor(light: DirectionalLight): Vec3 {
    return light.color.clone().multiply(light.intensity);
}