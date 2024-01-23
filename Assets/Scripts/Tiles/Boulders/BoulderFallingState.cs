using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;

public class BoulderFallingState : BoulderBaseState
{
    public BoulderFallingState(ActiveBoulder currentContext, BoulderStateFactory stateFactory) : base(currentContext, stateFactory)
    {
    }

    public override void CheckSwitchState()
    {
        /*
        if (_context.CheckOtherObject(Vector3.down, 0.1f))
        {
            _context.MotionY = 0f;
            //SwitchStates(_factory.Yield());
        }
        //RaycastHit2D hit = Physics2D.Raycast(_context.transform.position, Vector2.down);
        ActiveBoulder boulder;
        if (boulder = _context.checkOtherBoulder(Vector3.down, 2.5f))
        {
            // we have a conflict with another boulder
            // a falling boulder will only yield to a boulder that is already moving left
            //Debug.Log("boulder conflict");
            if (boulder.pushDirection == -1 && boulder.gameObject.transform.position.x - _context.transform.position.x < 0.7f)
            {
                SwitchStates(_factory.Yield());
                Debug.Log("yielding");
                return;
            }
        }
        else*/ 
        /*
        if (_context.Map.GetTile(_context.Map.WorldToCell(_context.transform.position + Vector3.down)))
        {
            SwitchStates(_factory.Settle());
        }
        */
    }

    public override void EnterState()
    {
        //Debug.Log("Boulder falling");
        _context.StateIndicator = Color.green;
        _context.pushDirection = 0;
        _context.rb.constraints = RigidbodyConstraints2D.FreezePositionX;
    }

    public override void ExitState()
    {
        _context.rb.constraints = RigidbodyConstraints2D.FreezeRotation;
        Vector3Int newPos = _context.Map.WorldToCell(_context.transform.position);
        _context.transform.position = newPos + new Vector3(0.5f, 0.5f, 0f);
    }

    public override void OnCollisionEnter(Collision2D collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            // kill player
            return;
        }
        /*
        else if (collision.gameObject.CompareTag("EnemyLiving"))
        {
            // kill enemy
            return;
        }*/
        
        if (collision.gameObject.CompareTag("Boulder"))
        {
            // if the boulder we hit is lower than this one, stop
            if (collision.gameObject.transform.position.y < _context.transform.position.y)
            {
                _context.MotionY = 0f;
            }
        }

        // check for plaform tiles
        TileBase platformTile;
        Tilemap platforms = MapManager.instance.GetPlatformMap();
        Vector3Int tilePos = platforms.WorldToCell(_context.transform.position);
        if (platformTile = platforms.GetTile(tilePos + Vector3Int.down))
        {
            // break them
            platforms.SetTile(tilePos + Vector3Int.down, null);
            platforms.SetTile(tilePos + Vector3Int.down + Vector3Int.left, null);
            platforms.SetTile(tilePos + Vector3Int.down + Vector3Int.right, null);
            return;
        }

        SwitchStates(_factory.Settle());
    }

    public override void UpdateState()
    {
        CheckSwitchState();

        //_context.rb.velocity = new Vector2(_context.rb.velocity.x, )
        //Debug.Log(_context.checkOtherBoulder(Vector3.down, 2.5f));
        _context.MotionY = Mathf.Max(_context.MotionY + (Physics2D.gravity.y * 0.5f) * Time.deltaTime, -_context.terminalVelocity);
        _context.MotionX = 0f;
    }
}
