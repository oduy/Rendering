﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


Shader "Unlit/TextureSplatting"
{
	Properties
	{
		_TranTex ("Texture", 2D) = "white" {}
		[NoScaleOffset] _Texture1 ("Texture 1", 2D) = "white" {}
		[NoScaleOffset] _Texture2 ("Texture 2", 2D) = "white" {}
		[NoScaleOffset] _Texture3 ("Texture 3", 2D) = "white" {}
		[NoScaleOffset] _Texture4 ("Texture 4", 2D) = "white" {}
	}

	SubShader 
	{
		Pass
		{
			CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram
			#include "UnityCG.cginc"

			sampler2D _TranTex;
			float4 _TranTex_ST;

			sampler2D _Texture1, _Texture2, _Texture3, _Texture4;


			struct Tran{
				float4 position: SV_POSITION;
				float2 uv: TEXCOORD0;
				float2 uvSplat: TEXCOORD1;
			};

			struct VertexData{
				float4 position: POSITION;
				float2 uv: TEXCOORD0;
			};

			Tran MyVertexProgram(VertexData v)
			{
				Tran t;
				t.position = UnityObjectToClipPos(v.position);
				//t.uv = v.uv * _TranTex_ST.xy + _TranTex_ST.zw;
				t.uv = TRANSFORM_TEX(v.uv, _TranTex);
				t.uvSplat = v.uv;
				return t;
			}
			
			float4 MyFragmentProgram(Tran i): SV_TARGET
			{
				float4 splat = tex2D(_TranTex, i.uvSplat);
				return 
					tex2D(_Texture1, i.uv) * splat.r + 
					tex2D(_Texture2, i.uv) * splat.g + 
					tex2D(_Texture3, i.uv) * splat.b + 
					tex2D(_Texture4, i.uv) * (1 - splat.r - splat.g - splat.b);
			}
			
			ENDCG
		}
		
	}
}