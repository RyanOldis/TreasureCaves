using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoulderPushState : BoulderBaseState
{
    private Vector2 _destination;
    private bool _internalYield = false;

    public BoulderPushState(ActiveBoulder currentContext, BoulderStateFactory stateFactory) : base(currentContext, stateFactory)
    {
        float newX = Mathf.Floor(_context.transform.position.x) + 0.5f + Mathf.Sign(_context.pushDirection);
        float newY = Mathf.Floor(_context.transform.position.y) + 0.5f;
        _destination = new Vector2(newX, newY);
        //Debug.Log("Boulder is at: " + _context.transform.position + " Destination tile is: " + _destination);
    }

    public override void CheckSwitchState()
    {
        float offset = Mathf.Abs(_destination.x - _context.transform.position.x);
        if (offset < 0.05f || offset > 1.02f)
        {
            _context.pushDirection = 0;
            SwitchStates(_factory.Settle());
            return;
        }
        _internalYield = false;

        // otherwise check for other boulders
        /*
        RaycastHit2D hit = Physics2D.Raycast(_context.transform.position, Vector2.right * _context.pushDirection);
        ActiveBoulder boulder;
        if (boulder = hit.transform.gameObject.GetComponent<ActiveBoulder>())
        {
            // we have a conflict with another boulder
            // a boulder moving right will yield to a falling boulder
            if (boulder.pushDirection == 0 && _context.pushDirection == 1)
            {
                SwitchStates(_factory.Yield());
            }
        }
        */
        // Pointcast 2 tiles over in the direction we're pushing in
        RaycastHit2D hit = _context.PointCast(_context.transform.position + new Vector3(_context.pushDirection * 2, 0f, 0f), _context.mask);
        if (!hit)
            return;
        ActiveBoulder otherBoulder = hit.transform.gameObject.GetComponent<ActiveBoulder>();

        if (otherBoulder.pushDirection > _context.pushDirection && !_context.hasYielded)
        {
            // This boulder is moving left, other is going right
            _context.hasYielded = true;
            _internalYield = true;
            _context.OtherBoulder = otherBoulder;
            Debug.Log("Yielding to other boulder");
            SwitchStates(_factory.Yield());
        }
    }

    public override void EnterState()
    {
        //Debug.Log("boulder push");
        _context.StateIndicator = Color.blue;
        _internalYield = false;
        
        // Set above activated boulder push direction to 0
        RaycastHit2D boulderHit = _context.PointCast(_context.transform.position + Vector3.up, _context.mask);
        if (boulderHit)
        {
            ActiveBoulder aboveBoulder = boulderHit.transform.gameObject.GetComponent<ActiveBoulder>();
            if (aboveBoulder)
            {
                aboveBoulder.ExternalSetFall();
            }
        }
        
        // Set reference to above diagonal boulder to this
        boulderHit = _context.PointCast(_context.transform.position + new Vector3(_context.pushDirection, 1f, 0f), _context.mask);
        if (boulderHit) // if pointcast hits something
        {
            ActiveBoulder diagonalBoulder = boulderHit.transform.gameObject.GetComponent<ActiveBoulder>();
            if (diagonalBoulder) // if hit is an active boulder
            {
                diagonalBoulder.ExternalSetYield();
                diagonalBoulder.OtherBoulder = _context;
                diagonalBoulder.SetStateYield(2.5f);
                Debug.Log("Hit a boulder diagonally");
            } else {
                Debug.Log("Hit was not a boulder: " + boulderHit.transform.gameObject.name);
            }
        } else {
            Debug.Log("Pointcast at: " + (_context.transform.position + new Vector3(_context.pushDirection, 1f, 0f)) + " missed");
        }
    }

    public override void ExitState()
    {
        if (_internalYield)
            return;
        _context.transform.position = _destination;
        _context.MotionX = 0f;
    }

    public override void OnCollisionEnter(Collision2D collision)
    {
        
    }

    public override void UpdateState()
    {
        if (_internalYield)
            return;
        CheckSwitchState();
        // Move in direction of pushDirection sign
        _context.MotionX = _context.pushSpeed * Mathf.Sign(_context.pushDirection);
        //_context.MotionX = Mathf.Pow(0.5f, Time.deltaTime * _context.pushSpeed) * Mathf.Sign(_context.pushDirection);
    }
}
