#version 300 es
precision highp int;
precision highp float;

struct DirectionalLight {
    vec3 direction;
    vec3 color;
};
struct PointLight {
    vec3 position;
    vec3 color;
    float radius;
};
struct SpotLight {
    vec3 position;
    vec3 direction;
    vec3 color;
    float cutoff;
};

#define NUM_DIR_LIGHTS 1
#define NUM_POINTS_LIGHT 2
#define NUM_SPOT_LIGHTS 2

uniform DirectionalLight directionalLights[NUM_DIR_LIGHTS];
uniform SpotLight spotLights[NUM_SPOT_LIGHTS];
uniform PointLight pointLights[NUM_POINTS_LIGHT];

uniform sampler2D normalTex;
uniform sampler2D diffuseTex;
uniform sampler2D specTex;
uniform samplerCube cubeTexture;

uniform vec3 cameraPosition;

in vec3 fragNormal;
in vec3 fragWorldPos;
in vec2 fragUV;
in mat3 TBN;

@import ./light;

out vec4 outColor;

void main() {
    vec3 normal = texture(normalTex, fragUV).rgb;
    normal = normalize(normal * 2.0 - 1.0);
    normal = normalize(TBN * normal);
    vec3 viewDir = normalize(cameraPosition - fragWorldPos);

    vec3 diffuseColor = texture(diffuseTex, fragUV).rgb;
    float specMask = texture(specTex, fragUV).x;
    vec3 envReflection = texture(cubeTexture, reflect(-viewDir, normal)).xyz;

    vec3 finalColor = vec3(0.0, 0.0, 0.0);

    for (int i = 0; i < NUM_DIR_LIGHTS; i++) {
        DirectionalLight light = directionalLights[i];
        vec3 sceneLight = mix(light.color, envReflection + light.color * 0.5, 0.5);

        float diffAmt = diffuse(light.direction, normal);
        float specAmt = specular(light.direction, viewDir, normal, 4.0) * specMask;

        vec3 envLighting =  envReflection * specMask * diffAmt;

        vec3 specColor = specMask * sceneLight * specAmt;

        finalColor += diffuseColor * diffAmt * light.color;
        finalColor += specColor * sceneLight;
    }

    for (int i = 0; i < NUM_POINTS_LIGHT; i++) {
        PointLight light = pointLights[i];
        vec3 sceneLight = mix(light.color, envReflection + light.color * 0.5, 0.5);

        vec3 toLight = light.position - fragWorldPos;
        vec3 lightDir = normalize(toLight);
        float distToLight = length(toLight);
        float falloff = 1.0 - distToLight / light.radius;

        float diffAmt = diffuse(lightDir, normal) * falloff;
        float specAmt = specular(lightDir, viewDir, normal, 4.0) * specMask * falloff;

        vec3 envLighting =  envReflection * specMask * diffAmt;
        vec3 specColor = specMask * sceneLight * specAmt;

        finalColor += diffAmt * sceneLight * diffuseColor;
        finalColor += specColor;
    }

    for (int i = 0; i < NUM_SPOT_LIGHTS; i++) {
        SpotLight light = spotLights[i];
        vec3 sceneLight = mix(light.color, envReflection + light.color * 0.5, 0.5);

        vec3 toLight = light.position - fragWorldPos;
        vec3 lightDir = normalize(toLight);
        float angle = dot(light.direction, -lightDir);

        float falloff = step(light.cutoff, angle);

        float diffAmt = diffuse(lightDir, normal) * falloff;
        float specAmt = specular(lightDir, viewDir, normal, 4.0) * specMask * falloff;

        vec3 envLighting = envReflection * specMask * diffAmt;
        vec3 specColor = specMask * sceneLight * specAmt;

        finalColor += diffAmt * sceneLight * diffuseColor;
        finalColor += specColor;
    }

	outColor = vec4(finalColor, 1.0);
}