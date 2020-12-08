#version 300 es
precision highp int;
precision highp float;

in vec3 position;
in vec3 normal;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat3 normalMatrix;

out vec3 fragNormal;
out vec3 fragWorldPos;

void main() {
	fragNormal = normalMatrix * normal;
	fragWorldPos = (modelViewMatrix * vec4(position, 1.0)).xyz;
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);  
}