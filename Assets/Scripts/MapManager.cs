using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;

public class MapManager : MonoBehaviour
{
    public static MapManager instance;

    [SerializeField]
    private Tilemap map;
    [SerializeField]
    private Tilemap platforms;
    [SerializeField]
    private Tilemap entities;
    [SerializeField]
    private Tilemap spikes;

    private void Awake()
    {
        instance = this;
    }

    public bool CheckForTile(Vector3Int pos)
    {
        bool terrainCheck = (map.GetTile(pos) != null);
        bool platformCheck = (platforms.GetTile(pos) != null);
        bool entityCheck = (entities.GetTile(pos) != null);

        return terrainCheck || platformCheck || entityCheck;
    }

    public Tilemap GetEntityMap()
    {
        return entities;
    }
    public Tilemap GetPlatformMap()
    {
        return platforms;
    }
    public Tilemap GetSpikeMap()
    {
        return spikes;
    }
    
    /*
    private void Update()
    {
        if (Input.GetMouseButtonUp(0))
        {
            Vector2 mousePos = Camera.main.ScreenToWorldPoint(Input.mousePosition);
            Vector3Int gridPos = entities.WorldToCell(mousePos);

            TileBase clickedTile = entities.GetTile(gridPos);
            int type = dataFromTiles[clickedTile].type;
            Debug.Log("At position " + gridPos + "there is a " + type);
        }
    }
    

    public int GetDataFromTerrain(Vector2 position)
    {
        Vector3Int gridPos = map.WorldToCell(position);
        TileBase tile = map.GetTile(gridPos);

        if (tile == null)
        {
            // air tile
            return -1;
        }
        return dataFromTiles[tile].type;
    }

    public int GetDataFromPlatforms(Vector2 position)
    {
        Vector3Int gridPos = platforms.WorldToCell(position);
        TileBase tile = platforms.GetTile(gridPos);

        if (tile == null)
        {
            // air tile
            return -1;
        }
        return dataFromTiles[tile].type;
    }

    public int GetDataFromEntities(Vector2 position)
    {
        Vector3Int gridPos = entities.WorldToCell(position);
        TileBase tile = entities.GetTile(gridPos);

        if (tile == null)
        {
            // air tile
            return -1;
        }
        return dataFromTiles[tile].type;
    }
    */
}
