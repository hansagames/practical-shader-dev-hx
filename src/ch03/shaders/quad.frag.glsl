#version 300 es
precision highp float;

out vec4 outColor;
in vec4 fragColor;
in vec2 fragUV;

void main()
{
	outColor = vec4(fragUV, 0.0, 1.0);
}