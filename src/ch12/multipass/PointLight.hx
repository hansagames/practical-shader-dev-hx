package ch12.multipass;

import externs.Ogl.Program;
import externs.Ogl.Vec3;

class PointLight extends Light {
    public var position: Vec3;
    public var intensity: Float;
    public var radius: Float;
    public var color: Vec3;

    public function new(?position: Vec3, ?color: Vec3, ?intensity: Float, ?radius: Float) {
        this.position = (position != null) ? position : new Vec3();
        this.color = (color != null) ? color : new Vec3(1, 1, 1);
        this.intensity = (intensity != null) ? intensity : 1;
        this.radius = (radius != null) ? radius : std.Math.POSITIVE_INFINITY;
    }

    override public function isPointLight(): Bool {
        return true;
    }

    override public function apply(shader: Program): Void {
        shader.uniforms.lightPos.value = position;
        shader.uniforms.lightCol.value = color.clone().multiply(intensity);
        shader.uniforms.lightRadius.value = radius;
    }
}