#version 310 es
precision mediump float;
precision highp int;

struct Light
{
    int lightType;
    highp vec4 lightPosition;
    highp vec4 lightColor;
    highp vec4 lightDirection;
    highp vec4 lightSize;
    highp float lightIntensity;
    highp mat4 lightDistAttenCurveParams;
    highp mat4 lightAngleAttenCurveParams;
    highp mat4 lightVP;
    int lightShadowMapIndex;
};

layout(binding = 0, std140) uniform DrawFrameConstants
{
    highp mat4 viewMatrix;
    highp mat4 projectionMatrix;
    highp vec3 ambientColor;
    highp vec3 camPos;
    int numLights;
    Light allLights[100];
} _43;

layout(binding = 1, std140) uniform DrawBatchConstants
{
    highp mat4 modelMatrix;
    highp vec3 diffuseColor;
    highp vec3 specularColor;
    highp float specularPower;
    highp float metallic;
    highp float roughness;
    highp float ao;
    uint usingDiffuseMap;
    uint usingNormalMap;
    uint usingMetallicMap;
    uint usingRoughnessMap;
    uint usingAoMap;
} _46;

struct debugPushConstants
{
    highp float level;
    highp float layer_index;
};

uniform debugPushConstants u_pushConstants;

layout(binding = 0) uniform highp samplerCubeArray depthSampler;
layout(binding = 0) uniform highp sampler2D diffuseMap;
layout(binding = 1) uniform highp sampler2DArray shadowMap;
layout(binding = 2) uniform highp sampler2DArray globalShadowMap;
layout(binding = 3) uniform highp samplerCubeArray cubeShadowMap;
layout(binding = 4) uniform highp samplerCubeArray skybox;
layout(binding = 5) uniform highp sampler2D normalMap;
layout(binding = 6) uniform highp sampler2D metallicMap;
layout(binding = 7) uniform highp sampler2D roughnessMap;
layout(binding = 8) uniform highp sampler2D aoMap;
layout(binding = 9) uniform highp sampler2D brdfLUT;

layout(location = 0) out highp vec3 color;
layout(location = 0) in highp vec3 UVW;

void main()
{
    color = textureLod(depthSampler, vec4(UVW, u_pushConstants.layer_index), u_pushConstants.level).xyz;
}

