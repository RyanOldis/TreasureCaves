using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;
using static UnityEngine.RuleTile.TilingRuleOutput;

public class EntityBox : MonoBehaviour
{
    public LayerMask mask;
    public float rayDistance;
    [SerializeField]
    static float fallingWaitTime;
    [SerializeField]
    private Tilemap map;

    private List<Vector3> directions;

    // Start is called before the first frame update
    void Start()
    {
        directions = new List<Vector3>();

        directions.Add(Vector2.up * rayDistance);
        directions.Add((Vector2.up + Vector2.left) * rayDistance);
        directions.Add((Vector2.up + Vector2.right) * rayDistance);
        directions.Add(Vector2.left * rayDistance);
        directions.Add(Vector2.right * rayDistance);
        directions.Add(Vector2.down * rayDistance);
        directions.Add((Vector2.down + Vector2.left) * rayDistance);
        directions.Add((Vector2.down + Vector2.right) * rayDistance);
    }
    /*
    IEnumerator ActivateEntityCascade(Tilemap map, Vector2 position)
    {
        // Create 'active' gameobject, and set the tile to nothing
        //Instantiate(Object, map.CellToWorld(new Vector3Int((int)position.x, (int)position.y, 0)), Quaternion.identity);
        //map.SetTile(new Vector3Int((int)position.x, (int)position.y, 0), null);

        float yOffset = 1f;

        // Check the tile above. If there's a valid tile there, activate it
        TileData nextTile;
        while (nextTile = map.GetTile(new Vector3Int((int)position.x, (int)(position.y + yOffset))) as TileData)
        {
            nextTile.Activate(map, position);

            yOffset += 1f;
            yield return new WaitForSeconds(fallingWaitTime);
        }
        Debug.Log("Reached end of acivatable entities");
    }
    */
    private void OnCollisionEnter2D(Collision2D collision)
    {
        // We have a hit with the entities map.
        List<TileData> hits = new List<TileData>();
        // Now check in 8 directions to see which tiles we hit
        for (int i = 0; i < 8; i++)
        {
            Vector3Int hitSpot = map.WorldToCell(transform.position + directions[i]);
            hits.Add(map.GetTile(hitSpot) as TileData);
            hits[i]?.OnPlayerHit(map, hitSpot, transform.position);
            //Debug.Log("Passing in: " + hitSpot + " with a direction of: " + directions[i]);
            //Debug.Log(hits[i]);
        }
        //Debug.Log("-------------");
    }

    private void OnDrawGizmos()
    {
        /*
        Gizmos.DrawRay(transform.position, Vector2.up);
        Gizmos.DrawRay(transform.position, Vector2.down);
        Gizmos.DrawRay(transform.position, Vector2.left);
        Gizmos.DrawRay(transform.position, Vector2.right);

        Gizmos.DrawRay(transform.position, Vector2.up + Vector2.right);
        Gizmos.DrawRay(transform.position, Vector2.up + Vector2.left);
        Gizmos.DrawRay(transform.position, Vector2.down + Vector2.left);
        Gizmos.DrawRay(transform.position, Vector2.down + Vector2.right);
        */
        Gizmos.DrawWireCube(transform.position + Vector3.up * rayDistance, Vector3.one * 0.1f);
        Gizmos.DrawWireCube(transform.position + (Vector3.up + Vector3.right) * rayDistance, Vector3.one * 0.1f);
        Gizmos.DrawWireCube(transform.position + (Vector3.up + Vector3.left) * rayDistance, Vector3.one * 0.1f);
        Gizmos.DrawWireCube(transform.position + Vector3.left * rayDistance, Vector3.one * 0.1f);
        Gizmos.DrawWireCube(transform.position + Vector3.right * rayDistance, Vector3.one * 0.1f);
        Gizmos.DrawWireCube(transform.position + Vector3.down * rayDistance, Vector3.one * 0.1f);
        Gizmos.DrawWireCube(transform.position + (Vector3.down + Vector3.left) * rayDistance, Vector3.one * 0.1f);
        Gizmos.DrawWireCube(transform.position + (Vector3.down + Vector3.right) *rayDistance, Vector3.one * 0.1f);
    }
}