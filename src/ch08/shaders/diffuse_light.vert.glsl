#version 300 es
precision highp int;
precision highp float;

in vec3 position;
in vec2 uv;
in vec3 normal;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat3 normalMatrix;

out vec2 fragUV;
out vec3 fragNormal;

void main() {
	fragUV = uv;
	fragNormal = normalMatrix * normal;
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);  
}