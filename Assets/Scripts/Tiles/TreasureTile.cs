using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu]
public class TreasureTile : TileData
{
    public TreasureTile()
    {
    }

    public override void OnArrowHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos)
    {
        //throw new System.NotImplementedException();
    }

    public override void OnDynamiteHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos)
    {
        //throw new System.NotImplementedException();
    }

    public override void OnGravityHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos)
    {
        //throw new System.NotImplementedException();
    }

    public override void OnPlayerHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos, Vector3 playerPos)
    {
        BreakThis(map, pos);
        Debug.Log("Collected treasure from" + pos);
    }
}
