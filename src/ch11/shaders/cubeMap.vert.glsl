#version 300 es
precision highp int;
precision highp float;

in vec3 position;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

out vec3 fragPos;

void main() {
    fragPos = position;
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);  
}