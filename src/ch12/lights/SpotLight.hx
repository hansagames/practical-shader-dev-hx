package ch12.lights;

import externs.Ogl.Vec3;

class SpotLight {
    public var position: Vec3;
    public var direction: Vec3;
    public var color: Vec3;
    public var intensity: Float;
    public var cutoff: Float;
    public function new(?position: Vec3, ?direction: Vec3, ?color: Vec3, ?intensity: Float, ?cutoff: Float) {
        this.position = (position != null) ? position : new Vec3();
        this.direction = (direction != null) ? direction : new Vec3();
        this.color = (color != null) ? color : new Vec3(1, 1, 1);
        this.intensity = (intensity != null) ? intensity : 1;
        this.cutoff = (cutoff != null) ? cutoff : Math.PI;
    }
}
function getLightColor(light: SpotLight): Vec3 {
    return light.color.clone().multiply(light.intensity);
}