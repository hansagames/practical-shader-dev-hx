#version 300 es
precision highp int;
precision highp float;

in vec3 fragPos;

uniform samplerCube cubeTexture;

out vec4 outColor;

void main() {

	outColor = texture(cubeTexture, fragPos);
}