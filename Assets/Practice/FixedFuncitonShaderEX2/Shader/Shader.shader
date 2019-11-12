Shader "Unlit/Shader"
{
	Properties
	{
		_Color("Main Color", color) = (1,1,1,1)
		_Ambient("Ambient", color) = (0.3, 0.3, 0.3, 0)
		_Specular("Specular", Color) = (1,1,1,1)
		_Shininess("Shininess", Range(0,8)) = 4
		_Emission("Emission", Color) = (1,1,1,1)
		_MainTex("Main Texture", 2D) = ""
    }
    SubShader
    {
		pass
		{
			material
			{
				diffuse[_Color]
				ambient[_Ambient]
				specular[_Specular]
				shininess[_Shininess]
				emission[_Emission]
			}
			lighting on
			separatespecular on
			
			SetTexture[_MainTex]
			{
				Combine texture
			}
		}
    }
}
