Shader "Unlit/Tran"
{
	Properties
	{
		_Tran("Tran", Color) = (1,1,1,1)
	   _TranTex("Texture", 2D) = "white"
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM

			#pragma vertex TranVerTexProgram
			#pragma fragment TranFragmentProgram
			#include "UnityCG.cginc"

			float4 _Tran;
			sampler2D _TranTex;
			float4 _TranTex_ST;

			struct Tran {
				float4 position: SV_POSITION;
				float2 uv: TEXCOORD0;
			};

			struct VertexData {
				float4 position: POSITION;
				float2 uv: TEXCOORD0;
			};

			Tran TranVerTexProgram(VertexData v) {
				Tran t;
				t.position = UnityObjectToClipPos(v.position);
				t.uv = TRANSFORM_TEX(v.uv, _TranTex);
				return t;
			}

			float4 TranFragmentProgram(Tran i) : SV_TARGET{
				return tex2D(_TranTex, i.uv) *_Tran;
			}

			ENDCG
        }
    }
}
