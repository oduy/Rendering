Shader "Unlit/FixFunctionShader"
{
	Properties{
		_Color("Tran color", color) = (1,1,1,1)
		_Ambient("Ambient", COLOR) = (1, 1, 1, 1)
		_Specular("Specular", COLOR) = (1, 1, 1, 1)
		_Shininess("Shiniess", Range(0,8)) = 4
		_Emission("Emission", COLOR) = (1,1,1,1)
	}

	SubShader{
		Pass
		{
			Material
			{
				diffuse [_Color]
				ambient [_Ambient]
				specular [_Specular]
				shininess [_Shininess]
				emission [_Emission]
			}
			Lighting on
			separatespecular on
			
		}
	}
}
