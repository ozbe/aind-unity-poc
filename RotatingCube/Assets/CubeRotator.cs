using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeRotator : MonoBehaviour
{
    public float speed = 100;
    public float waitTime = 2.0f;
    private IEnumerator coroutine;

    void Start()
    {
    	coroutine = WaitAndQuit();
        StartCoroutine(coroutine);
    }

    void Update()
    {
        transform.Rotate(new Vector3(0, speed * Time.deltaTime, 0));
    }

    private IEnumerator WaitAndQuit()
    {
        yield return new WaitForSeconds(waitTime);
        Debug.Log("Quit");
        Application.Quit();
    }
}