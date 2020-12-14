#version 300 es
precision highp int;
precision highp float;

in vec3 position;
in vec3 normal;
in vec2 uv;
in vec3 tangent;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat3 normalMatrix;

out vec3 fragWorldPos;
out vec2 fragUV;
out mat3 TBN;

void main() {
	vec3 T = normalize(normalMatrix * tangent.xyz);
	vec3 B = normalize(normal * cross(tangent.xyz, normal.xyz));
	vec3 N = normalize(normalMatrix * normal);

	TBN = mat3(T, B, N);

	fragUV = uv;
    fragWorldPos = (modelViewMatrix * vec4(position, 1.0)).xyz;
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);  
}