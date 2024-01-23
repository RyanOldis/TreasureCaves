using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerIdleState : PlayerBaseState
{
    private float _deaccelRate;

    public PlayerIdleState(PlayerController currentContext, PlayerStateFactory currentFactory) : base(currentContext, currentFactory)
    {
        _isRootState = false;
        InitializeSubstate();

        _deaccelRate = _context.deacellerationRate;
    }

    public override void CheckSwitchState()
    {
        //throw new System.NotImplementedException();
        if (_context.MovePerformed)
        {
            SwitchState(_factory.Move());
        }
    }

    public override void EnterState()
    {
        //_context.calculatedMotion.x = 0f;
        //Debug.Log("idle");
    }

    public override void ExitState()
    {
        
    }

    public override void InitializeSubstate()
    {
        
    }

    public override void OnCollisionEnter(Collision2D collision)
    {
        
    }

    public override void OnCollisionExit(Collision2D collision)
    {
        
    }

    public override void OnTriggerEnter(Collider2D collision)
    {
        
    }

    public override void OnTriggerExit(Collider2D collision)
    {
        
    }

    public override void UpdateState()
    {
        CheckSwitchState();
        //Debug.Log(_context.PreviousMotion);
        //_context.PreviousMotion = _context.PreviousMotion * _deaccelRate * Time.deltaTime;
        PlayerMovingState.AccelerationPotential = Mathf.Lerp(PlayerMovingState.AccelerationPotential, 0f, _deaccelRate * Time.deltaTime);
        _context.MotionX = _context.PreviousMotion.x * PlayerMovingState.AccelerationPotential;
    }

    void RoadrunnerStop()
    {

    }
}
