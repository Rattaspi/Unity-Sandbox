using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class Reflection_Camera : MonoBehaviour {
    [HideInInspector]
    [SerializeField]
    private Camera _camera;
    private int _downResFactor = 1;

    private string _globalReflexionName = "_globalReflexionTexture";
	
	// Update is called once per frame
	void Update () {
        GenerateRT();
	}

    void GenerateRT(){
        _camera = GetComponent<Camera>();

        if(_camera.targetTexture != null){
            RenderTexture tmp = _camera.targetTexture;
            _camera.targetTexture = null;
            DestroyImmediate(tmp);
        }

        _camera.targetTexture = new RenderTexture(_camera.pixelWidth >> _downResFactor, _camera.pixelHeight >> _downResFactor, 16);
        _camera.targetTexture.filterMode = FilterMode.Bilinear;

        Shader.SetGlobalTexture(_globalReflexionName, _camera.targetTexture);
    }
}
