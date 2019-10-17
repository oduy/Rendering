Shader "Unlit/TextureWithDetail"
{
    Properties
    {
        _Tran ("Tran", Color) = (1,1,1,1)
        _TranTex ("Texture", 2D) = "white" 
        _DetailTranTex ("Detail Texture", 2D) = "gray"{}
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
            sampler2D _TranTex, _DetailTranTex;
            float4 _TranTex_ST, _DetailTranTex_ST;


            struct Tran{
                float4 position: SV_POSITION;
                float2 uv: TEXCOORD0;
                float2 uvDetail : TEXCOORD1;
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
                t.uvDetail = TRANSFORM_TEX(v.uv, _DetailTranTex);
                return t;
            }
            
            float4 MyFragmentProgram(Tran i): SV_TARGET
            {
                float4 color = tex2D(_TranTex, i.uv) *_Tran;
                color *= tex2D(_TranTex, i.uvDetail) * 2;
                return color;
            }
            
            ENDCG
        }
    }
}
