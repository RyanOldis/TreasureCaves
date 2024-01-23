using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;

public class Arrow : MonoBehaviour
{
    public float speed;
    public float castDistance;
    [SerializeField]
    private Tilemap _entityMap;
    bool _wait;
    public float waitTime;
    public float waitHit;

    // Start is called before the first frame update
    void Awake()
    {
        _entityMap = MapManager.instance.GetEntityMap();
        _wait = true;
        StartCoroutine(StartUpdating());
    }

    IEnumerator StartUpdating()
    {
        yield return new WaitForSeconds(waitTime);
        _wait = false;
    }

    IEnumerator OnHit()
    {
        yield return new WaitForSeconds(waitHit);
        
        Vector3Int tilePos = _entityMap.WorldToCell(transform.position + (transform.up * castDistance));
        TileData tile = _entityMap.GetTile(tilePos) as TileData;
        //Debug.Log(tile);
        tile?.OnArrowHit(_entityMap, tilePos);
        Destroy(this.gameObject);
    }

    // Update is called once per frame
    void Update()
    {
        if (_wait)
            return;
        transform.Translate(transform.up * Time.deltaTime * speed, Space.World);
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            return;
        }
        StartCoroutine(OnHit());
        _wait = true;
    }

    private void OnDrawGizmos()
    {
        Gizmos.DrawWireSphere(transform.up, 0.1f);
    }
}
