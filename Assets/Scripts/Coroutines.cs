using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Coroutines : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        Debug.Log("Starting coroutine");
        StartCoroutine(MyRoutine());
        Debug.Log("done");
    }

    IEnumerator MyRoutine()
    {
        Debug.Log("Entered coroutine...");

        yield return new WaitForSeconds(10f);

        Debug.Log("Coroutine ending");
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
