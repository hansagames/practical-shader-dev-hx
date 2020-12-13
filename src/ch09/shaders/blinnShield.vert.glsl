#version 300 es
precision highp int;
precision highp float;

in vec3 position;
in vec3 normal;
in vec2 uv;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat3 normalMatrix;

out vec3 fragNormal;
out vec3 fragWorldPos;
out vec2 fragUV;

void main() {
	fragUV = uv;
	fragNormal = normalMatrix * normal;
    fragWorldPos = (modelViewMatrix * vec4(position, 1.0)).xyz;
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);  
}