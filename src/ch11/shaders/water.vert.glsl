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
uniform float time;

out vec3 fragWorldPos;
out vec2 fragUV;
out vec2 fragUV2;
out mat3 TBN;

void main() {
	vec3 T = normalize(normalMatrix * tangent.xyz);
	vec3 B = normalize(normalMatrix * cross(tangent.xyz, normal.xyz));
	vec3 N = normalize(normalMatrix * normal);

	TBN = mat3(T, B, N);

	float t = time * 0.05;
	float t2 = time * 0.02;
	fragUV = vec2(uv.x + t, uv.y) * 3.0;
	fragUV2= vec2(uv.x + t2, uv.y - t2) * 2.0;
    fragWorldPos = (modelViewMatrix * vec4(position, 1.0)).xyz;
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);  
}