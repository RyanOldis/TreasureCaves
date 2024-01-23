using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.Tilemaps;

[CreateAssetMenu]
public class BoulderTile : TileData
{
    public override GameObject Activate(Tilemap map, Vector3Int position, bool activatedFromBoulder = true, float directionX = 0f, float directionY = 0f, bool wasPushed = false)
    {
        TileBase belowTile = map.GetTile(position + Vector3Int.down);
        Vector2 activationDirection = new Vector2(directionX, directionY);
        //Debug.Log((bool)(belowTile as BoulderTile) + " " + activatedFromBoulder);

        if (belowTile as BoulderTile || activatedFromBoulder)
        {
            if (activationDirection != Vector2.up && belowTile is not BoulderTile)
            {
                return null;
            }
            // we can push if there is a boulder and an empty space next to this tile
            bool left = (bool)(map.GetTile(position + Vector3Int.left) as BoulderTile);
            bool right = (bool)(map.GetTile(position + Vector3Int.right) as BoulderTile);

            if (left ^ right) // if left or right, but not both or niether
            {
                int push = (Convert.ToInt32(!left) * -1) + Convert.ToInt32(!right);
                GameObject obj = base.Activate(map, position, true, directionX, directionY, true);
                ActiveBoulder boulder = obj.GetComponent<ActiveBoulder>();
                boulder.pushDirection = push;

                //Debug.Log("left: " + left + " right: " + right + " push: " + push);
                return obj;
            }
        }
        
        return base.Activate(map, position, true, directionX, directionY, false);
    }

    public override void OnArrowHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos)
    {
        
    }

    public override void OnDynamiteHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos)
    {
        BreakThis(map, pos);
    }

    public override void OnGravityHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos)
    {
        
    }

    public override void OnPlayerHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos, Vector3 playerPos)
    {
        // first, get the push direction
        //int above = pos.y - map.WorldToCell(playerPos).y;
        int push = pos.x - map.WorldToCell(playerPos).x;
        if (push == 0 || (playerPos.y - 0.75f) > pos.y)
            return; // we're above, so don't activate
        if (MapManager.instance.CheckForTile(pos + (Vector3Int.right * push)))
            return; // there's another tile in the way
        GameObject obj = Activate(map, pos);
        ActiveBoulder boulder = obj.GetComponent<ActiveBoulder>();
        boulder.pushDirection = push;
        //boulder.ExternalSetPush();
    }
}
