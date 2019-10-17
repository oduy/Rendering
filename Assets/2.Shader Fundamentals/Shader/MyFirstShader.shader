// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


Shader "Unlit/MyFirstShader"
{
	Properties
	{
		_Tran ("Tran", Color) = (1,1,1,1)
		_TranTex ("Texture", 2D) = "white" 
	}

	SubShader 
	{
		Pass
		{
			CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram
			#include "UnityCG.cginc"

			float4 _Tran;
			sampler2D _TranTex;
			float4 _TranTex_ST;


			struct Tran{
				float4 position: SV_POSITION;
				float2 uv: TEXCOORD0;
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
				return t;
			}
			
			float4 MyFragmentProgram(Tran i): SV_TARGET
			{
				
				return tex2D(_TranTex, i.uv) *_Tran;
			}
			
			ENDCG
		}
		
	}
}
