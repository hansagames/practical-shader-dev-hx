package ch12.lights;

import externs.Ogl.Vec3;

class PointLight {
    public var position: Vec3;
    public var color: Vec3;
    public var intensity: Float;
    public var radius: Float;
    public function new(?position: Vec3, ?color: Vec3, ?intensity: Float, ?radius: Float) {
        this.position = (position != null) ? position : new Vec3();
        this.color = (color != null) ? color : new Vec3(1, 1, 1);
        this.intensity = (intensity != null) ? intensity : 1;
        this.radius = (radius != null) ? radius : std.Math.POSITIVE_INFINITY;
    }
}
function getLightColor(light: PointLight): Vec3 {
    return light.color.clone().multiply(light.intensity);
}