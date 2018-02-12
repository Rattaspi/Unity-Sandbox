Shader "Custom/Mirror_Reflection" {
	Properties{
		_MainTexture("Mirror reflection texture", 2D) = "white" {}
	}

	SubShader{
		Tags{
			"Queue" = "Transparent"
			"PreviewType" = "Plane"
		}

		Pass{
			ZWrite Off
			Cull Off
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vertexShader;
			#pragma fragment fragmentShader;
			#include "UnityCG.cginc"

			struct input {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				half4 color : COLOR;
			};

			struct vertexOutuput {
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				half4 color : COLOR;
			};

			vertexOutuput vertexShader(input i) {
				vertexOutuput o;
				o.vertex = UnityObjectToClipPos(i.vertex);
				o.uv = i.uv;
				o.color = i.color;
				return o;
			}

			sampler2D _MainTexture;
			float4 fragmentShader(vertexOutuput i) {
				return tex2D(_MainTexture, i.uv) * i.color;
			}
			ENDCG
		}
	}
}
