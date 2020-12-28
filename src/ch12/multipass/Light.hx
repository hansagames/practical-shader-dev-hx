package ch12.multipass;

import externs.Ogl.Program;

abstract class Light {
    public function isPointLight(): Bool {
        return false;
    }
    abstract public function apply(shader: Program): Void;
}