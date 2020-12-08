#version 300 es
precision highp int;
precision highp float;

in vec3 position;
in vec2 uv;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

out vec2 fragUV;

void main() {
	fragUV = uv;
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);  
}