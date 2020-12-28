package ch12.multipass;

import externs.Ogl.Program;
import externs.Ogl.Vec3;

class DirectionalLight extends Light {
    public var direction: Vec3;
    public var color: Vec3;
    public var intensity: Float;

    public function new(?direction: Vec3, ?color: Vec3, ?intensity: Float) {
        this.direction = (direction != null) ? direction : new Vec3();
        this.color = (color != null) ? color : new Vec3(1, 1, 1);
        this.intensity = (intensity != null) ? intensity : 1;
    }

    override public function apply(shader: Program): Void {
        shader.uniforms.lightDir.value = direction.clone().negate().normalize();
        shader.uniforms.lightCol.value = color.clone().multiply(intensity);
    }
}