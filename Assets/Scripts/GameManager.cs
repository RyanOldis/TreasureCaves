using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{

    public static GameManager instance;

    private bool doorOpen;
    private float doorOpeningValue = 0.381f;
    [SerializeField]
    Material doorMat;

    int noOfTreasureChests;
    int treasureCollected = 0;

    int score = 0;

    private bool lifeCollected, gemCollected;

    bool canSwitchCharacters;

    // Start is called before the first frame update
    void Start()
    {
        instance = this;
        noOfTreasureChests = 0;

        doorOpen = false;
    }

    // Update is called once per frame
    void Update()
    {
        if (doorOpen)
        {
            doorOpeningValue = Mathf.Lerp(doorOpeningValue, 1f, 0.15f * Time.deltaTime);
            doorMat.SetFloat("_Opening", doorOpeningValue);
        }
    }

    public void SetTreasure(int treasure)
    {
        noOfTreasureChests = treasure;
    }

    public void AddTreasure()
    {
        treasureCollected++;
        score += 55;
        if (treasureCollected == noOfTreasureChests)
        {
            // open the door
            doorOpen = true;
        }
    }

    public void AddScore(int toAdd)
    {
        score += toAdd;
    }
}
