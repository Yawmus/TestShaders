﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/shader" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader {

        Pass {
            CGPROGRAM

            #pragma vertex MyVertexProgram
            #pragma fragment MyFragmentProgram

            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            
            struct Interpolators {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            struct VertexData {
                float4 position : POSITION;
                float2 uv : TEXCOORD0;
            };
            
            Interpolators MyVertexProgram (VertexData v){
                Interpolators i;
                i.position = UnityObjectToClipPos(v.position);
                i.uv = v.uv;
                return i;
            }

            float4 MyFragmentProgram (Interpolators i) : SV_TARGET{
                return tex2D(_MainTex, i.uv);
            }

            ENDCG
        }
    }
}